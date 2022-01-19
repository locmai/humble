# TODO handle exception better
# TODO make secret safer for parsers / add secret utils
# TODO add checks and self-fix script
# TODO clean up secrets resource from authentik and gitea
from kubernetes import client, config
from hvac import Client
import base64
import time
import os
import requests
import secrets

print('Start initializing')

# for local development
# config.load_kube_config(config_file='../../metal/kubeconfig.yaml')
# vault_client = Client(url='http://localhost:43975', verify=False)

time.sleep(30)
# Init kubernetes client
config.load_incluster_config()
k8s_client = client.CoreV1Api()

vault_pod_is_running = False
while not vault_pod_is_running:
    time.sleep(3)
    print('Waiting for vault to be running ...')
    vault_pod = k8s_client.read_namespaced_pod('vault-0', 'platform')
    if vault_pod.status.container_statuses[0].state.running is not None:
        vault_pod_is_running = True


print('Initializing Vault ...')

vault_client = Client(
    url='http://vault.platform.svc.cluster.local:8200/', verify=False)

shares = 5
threshold = 3

result = vault_client.sys.initialize(shares, threshold)
root_token = result['root_token']
keys = result['keys']

print(f"Vault Sys Initialized {vault_client.sys.is_initialized()}")

print('Unsealing Vault ...')

unseal_response = vault_client.sys.submit_unseal_keys(keys)

print(f"Vault is Unsealed: {not vault_client.sys.is_sealed()}")


secret_data = {
    'root_token': base64.b64encode(bytes(root_token, 'utf-8')).decode("utf-8")
}

for i in range(len(keys)):
    secret_data[f"key{i}"] = base64.b64encode(
        bytes(keys[i], 'utf-8')).decode("utf-8")

secret_name = "vault-init-secrets"
vault_secrets = client.V1Secret(
    metadata={
        'name': secret_name,
    },
    data=secret_data
)

k8s_client.create_namespaced_secret('platform', body=vault_secrets)

print(f"Created secret: {secret_name}")

# Re-init client with root_token
vault_client = Client(
    url='http://vault.platform.svc.cluster.local:8200/', token=root_token, verify=False)

# Enable Kubernetes auth
k8s_addr = os.getenv('KUBERNETES_PORT_443_TCP_ADDR')
k8s_ca_crt = k8s_client.read_namespaced_config_map(
    'kube-root-ca.crt', 'platform').data["ca.crt"]
k8s_vault_sa = k8s_client.read_namespaced_service_account('vault', 'platform')
k8s_vault_sa_jwt_data = k8s_client.read_namespaced_secret(
    k8s_vault_sa.secrets[0].name, "platform").data
k8s_vault_sa_jwt = base64.b64decode(k8s_vault_sa_jwt_data['token']).decode()

vault_client.sys.enable_auth_method(
    "kubernetes"
)

vault_client.create_kubernetes_configuration(
    kubernetes_host=f"https://{k8s_addr}:443",
    kubernetes_ca_cert=k8s_ca_crt,
    token_reviewer_jwt=k8s_vault_sa_jwt,
    mount_point="kubernetes"
)

# Create policies
project_prefix = "humble"
read_only_policy = """
path "secret/*" {
  capabilities = ["read", "list"]
}
"""

read_only_policy_name = f"{project_prefix}-read-only"
vault_client.sys.create_or_update_policy(
    name=read_only_policy_name,
    policy=read_only_policy,
)

admin_policy = """
path "sys" {
  capabilities = ["deny"]
}

path "secret/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
"""

admin_policy_name = f"{project_prefix}-admin"
vault_client.sys.create_or_update_policy(
    name=admin_policy_name,
    policy=admin_policy,
)

# Create vault-app role with read-only policy
vault_app_sa = k8s_client.read_namespaced_service_account(
    'vault-app', 'platform')
vault_app_sa_secret = k8s_client.read_namespaced_secret(
    vault_app_sa.secrets[0].name, "platform").data
vault_app_sa_token = base64.b64decode(vault_app_sa_secret['token']).decode()

vault_client.create_kubernetes_role("vault-kubernetes", [vault_app_sa.metadata.name, "external-secrets-kubernetes-external-secrets"], [
                                    'platform'], mount_point="kubernetes", policies=[read_only_policy_name])

main_secret_path = 'humble'
vault_client.sys.enable_secrets_engine(
    backend_type='kv',
    path=main_secret_path,
    options={
        'version': 2
    }
)

def gen_secret(length: int = 64):
    return secrets.token_urlsafe(length)

# Feed init secrets
secrets_list = {
    'ak_admin_token': gen_secret(),
    'ak_admin_password': gen_secret(32),
    'ak_gitea_oauth2_client_id ': gen_secret(40),
    'ak_gitea_oauth2_client_secret': gen_secret(128)
}

vault_client.secrets.kv.v2.create_or_update_secret(
    path="init",
    secret=secrets_list,
    mount_point="humble"
)

print('Secret initialized successfully!')
