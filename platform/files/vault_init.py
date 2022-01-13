from kubernetes import client, config
from hvac import Client
import base64, time, os

print('Start of everything')
# Init kubernetes client
# config.load_kube_config(config_file='../../metal/kubeconfig.yaml')
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

# vault_client = Client(url='http://localhost:44927/', verify=False)
vault_client = Client(url='http://vault.platform.svc.cluster.local:8200/', verify=False)

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
    'root_token': base64.b64encode(bytes(root_token,'utf-8')).decode("utf-8") 
}

for i in range(len(keys)):
    secret_data[f"key{i}"] = base64.b64encode(bytes(keys[i],'utf-8')).decode("utf-8")

secret_name = "vault-init-secrets"
vault_secrets = client.V1Secret(
    metadata= {
       'name': secret_name,
    },
    data = secret_data
)

k8s_client.create_namespaced_secret('platform', body=vault_secrets )

print(f"Created secret: {secret_name}")

# WIP
# # Enable Kubernetes auth
# # Create internal-app service account
# vault_app_sa = k8s_client.read_namespaced_service_account('vault-app', 'platform')
# vault_app_sa_secret = v1.read_namespaced_secret(vault_app_sa.secrets[0].name, "platform").data
# vault_app_sa_token = base64.b64decode(vault_app_sa_secret['token'])).decode()

# # vault write auth/kubernetes/config \
# #    token_reviewer_jwt="$(cat /var/run/secrets/kubernetes.io/serviceaccount/token)" \
# #    kubernetes_host=https://${KUBERNETES_PORT_443_TCP_ADDR}:443 \
# #    kubernetes_ca_cert=@/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
# k8s_addr = os.getenv('KUBERNETES_PORT_443_TCP_ADDR')
# k8s_ca_crt = k8s_client.read_namespaced_config_map('kube-root-ca.crt', 'platform')
# k8s_vault_sa = k8s_client.read_namespaced_service_account('vault', 'platform')
# vault_client.auth_kubernetes("kubernetes", vault_app_sa_token)
