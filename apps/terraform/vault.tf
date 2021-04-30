resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "default_kubernetes_auth_backend_config" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://${data.kubernetes_service.default_kubernetes_service.spec[0].cluster_ip}:443"
  kubernetes_ca_cert     = data.kubernetes_secret.vault_vault_token.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.vault_vault_token.data["token"]
}

resource "vault_policy" "apps" {
  name = "apps"

  policy = <<EOT
path "secret*" {
  capabilities = [ "create", "update", "read", "delete", "list" ]
}
EOT
}

resource "vault_kubernetes_auth_backend_role" "apps" {
  backend                          = vault_auth_backend.kubernetes.path
  role_name                        = "apps"
  bound_service_account_names      = ["apps"]
  bound_service_account_namespaces = [var.default_namespace]
  token_ttl                        = 3600
  token_policies                   = ["apps"]
}

resource "kubernetes_service_account" "apps" {
    metadata {
        name      = "apps"
        namespace = "apps"
    }
}