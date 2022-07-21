package main

import (
	"context"
	"log"

	b64 "encoding/base64"

	vault "github.com/hashicorp/vault/api"
	"github.com/sethvargo/go-password/password"
	v1 "k8s.io/api/core/v1"
	metav1 "k8s.io/apimachinery/pkg/apis/meta/v1"
	"k8s.io/client-go/kubernetes"
	"k8s.io/client-go/tools/clientcmd"
	// "k8s.io/client-go/tools/clientcmd"
)

func main() {
	k8sconfig, err := clientcmd.BuildConfigFromFlags("", "/home/locmai/Workspace/humble/metal/kubeconfig.prod.yaml")
	// k8sconfig, err := rest.InClusterConfig()
	if err != nil {
		panic(err.Error())
	}
	k8sclient, err := kubernetes.NewForConfig(k8sconfig)
	if err != nil {
		panic(err.Error())
	}

	// Initialize Vault config and client
	config := vault.DefaultConfig()
	config.Address = "http://localhost:8200"
	config.ConfigureTLS(&vault.TLSConfig{
		Insecure: true,
	})
	client, err := vault.NewClient(config)

	unseal_secrets, err := k8sclient.CoreV1().Secrets("platform").Get(context.TODO(), "vault-unseal-keys", metav1.GetOptions{})
	client.SetToken(string(unseal_secrets.Data["vault-root"]))

	if err != nil {
		log.Fatalf("unable to initialize Vault client: %v", err)
	}

	client.Sys().EnableAuthWithOptions("userpass", &vault.EnableAuthOptions{
		Type:        "userpass",
		Description: "Userpass authentication with Vault",
	})

	log.Print("enable auth userpass")

	secret, secret_err := k8sclient.CoreV1().Secrets("platform").Get(context.TODO(), "vault-admin-password", metav1.GetOptions{})
	log.Print("kubectl get secret vault-admin-password")

	admin_password, err := password.Generate(32, 3, 3, false, true)
	if secret_err == nil {
		decoded_password, _ := b64.StdEncoding.DecodeString(string(secret.Data["password"]))
		admin_password = string(decoded_password)
		log.Print("re-use admin password")
	}

	if err != nil {
		log.Fatal(err)
	}

	// vault write auth/userpass/users/admin
	if _, err := client.Logical().Write(
		"auth/userpass/users/admin",
		map[string]interface{}{
			"password": admin_password,
			"policies": "default",
			"disabled": false,
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write auth/userpass/users/admin")

	if secret_err != nil {
		_, err := k8sclient.CoreV1().Secrets("platform").Create(
			context.TODO(),
			&v1.Secret{
				ObjectMeta: metav1.ObjectMeta{Name: "vault-admin-password"},
				Data: map[string][]byte{
					"password": []byte(admin_password),
				},
			},
			metav1.CreateOptions{},
		)
		if err != nil {
			panic(err)
		}
		log.Print("kubectl create secret vault-admin-password")
	}

	// vault write identity/entity
	entity_path := "identity/entity"
	if _, err := client.Logical().Write(
		entity_path,
		map[string]interface{}{
			"name":     "admin",
			"metadata": "email=locmai0201@gmail.com,phone_number=123-456-7890",
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write " + entity_path + "/name/admin")

	entity, err := client.Logical().Read(entity_path + "/name/admin")
	if err != nil {
		log.Fatal(err)
	}
	entity_id, err := entity.TokenID()

	// vault write identity/group
	group_path := "identity/group"
	if _, err := client.Logical().Write(
		group_path,
		map[string]interface{}{
			"name":              "engineer",
			"member_entity_ids": entity_id,
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write " + group_path + "/name/engineer")

	group, err := client.Logical().Read(group_path + "/name/admin")
	if err != nil {
		log.Fatal(err)
	}
	group_id, err := group.TokenID()

	auths, err := client.Sys().ListAuth()

	// vault write identity/entity-alias
	alias_path := "identity/entity-alias"
	if _, err := client.Logical().Write(
		alias_path,
		map[string]interface{}{
			"name":           "admin",
			"canonical_id":   entity_id,
			"mount_accessor": auths["userpass/"].Accessor,
		}); err != nil {
		log.Fatal(err)
	}

	// vault write identity/oidc/assignment/admin-assignment
	admin_assignment_path := "identity/oidc/assignment/admin-assignment"
	if _, err := client.Logical().Write(
		admin_assignment_path,
		map[string]interface{}{
			"entity_ids": entity_id,
			"group_ids":  group_id,
		}); err != nil {
		log.Fatal(err)
	}

	// vault write identity/oidc/key/admin-key
	admin_key_path := "identity/oidc/key/admin-key"
	if _, err := client.Logical().Write(
		admin_key_path,
		map[string]interface{}{
			"allowed_client_ids": "*",
			"verification_ttl":   "2h",
			"rotation_period":    "1h",
			"algorithm":          "RS256",
		}); err != nil {
		log.Fatal(err)
	}

	// Boundary section
	// vault write identity/oidc/client/boundary
	client_boundary_path := "identity/oidc/client/boundary"
	if _, err := client.Logical().Write(
		client_boundary_path,
		map[string]interface{}{
			// "redirect_uris":    "http://127.0.0.1:3000/v1/auth-methods/oidc:authenticate:callback",
			"redirect_uris":    "https://authenticate.localhost.pomerium.io/oauth2/callback",
			"assignments":      "admin-assignment",
			"key":              "admin-key",
			"id_token_ttl":     "30m",
			"access_token_ttl": "1h",
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write identity/oidc/client/boundary")

	//	vault read -field=client_id identity/oidc/client/boundary
	boundary_client, err := client.Logical().Read(client_boundary_path)
	if err != nil {
		log.Fatal(err)
	}

	user_scope_template := `{
		"username": {{identity.entity.name}},
		"contact": {
			"email": {{identity.entity.metadata.email}},
			"phone_number": {{identity.entity.metadata.phone_number}}
		}
	}`

	// vault write identity/oidc/scope/user
	user_scope_path := "identity/oidc/scope/user"
	if _, err := client.Logical().Write(
		user_scope_path,
		map[string]interface{}{
			"description": "The user scope provides claims using Vault identity entity metadata",
			"template":    b64.StdEncoding.EncodeToString([]byte(user_scope_template)),
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write identity/oidc/scope/user")

	group_scope_template := `{
		"groups": {{identity.entity.groups.names}}
	}`
	// vault write identity/oidc/scope/groups
	group_scope_path := "identity/oidc/scope/groups"
	if _, err := client.Logical().Write(
		group_scope_path,
		map[string]interface{}{
			"description": "The groups scope provides the groups claim using Vault group membership",
			"template":    b64.StdEncoding.EncodeToString([]byte(group_scope_template)),
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write identity/oidc/scope/groups")

	email_scope_template := `{
		"email": {{identity.entity.metadata.email}}
	}`

	// vault write identity/oidc/scope/user
	email_scope_path := "identity/oidc/scope/email"
	if _, err := client.Logical().Write(
		email_scope_path,
		map[string]interface{}{
			"description": "The user scope provides claims using Vault identity entity metadata",
			"template":    b64.StdEncoding.EncodeToString([]byte(email_scope_template)),
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write identity/oidc/scope/email")

	// vault write identity/oidc/provider/vault-provider
	oidc_provider_path := "identity/oidc/provider/vault-provider"
	if _, err := client.Logical().Write(
		oidc_provider_path,
		map[string]interface{}{
			"allowed_client_ids": boundary_client.Data["client_id"],
			"scopes_supported":   "groups,user,email",
			"issuer":             "http://vault.platform.svc.cluster.local:8200",
		}); err != nil {
		log.Fatal(err)
	}
	log.Print("vault write identity/oidc/provider/vault-provider")
}