from hvac import Client
import base64
from kubernetes import client, config
import time

print('Start of everything')
# Init kubernetes client
# config.load_kube_config(config_file='../../metal/kubeconfig.yaml')
config.load_incluster_config()
k8s_client = client.CoreV1Api()

vault_pod_is_running = False

while not vault_pod_is_running:
    try:
        time.sleep(3)
        print('Waiting for vault to be running ...')
        vault_pod = k8s_client.read_namespaced_pod('vault-0', 'platform')
        if vault_pod.status.container_statuses[0].state.running is not None:
            vault_pod_is_running = True
    except Exception:
        continue

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
