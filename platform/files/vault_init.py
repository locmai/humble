# WIP
# import subprocess
# subprocess.check_call([sys.executable, "-m", "pip", "install", "hvac"])
# subprocess.check_call([sys.executable, "-m", "pip", "install", "kubernetes"])

from hvac import Client

print('Initializing Vault ...')

vault_client = Client(url='https://vault.maibaloc.com', token ='root', verify=False)

shares = 3
threshold = 2

result = vault_client.sys.initialize(shares, threshold)
root_token = result['root_token']
keys = result['keys']

print(f"Vault Sys Initialized {vault_client.sys.is_initialized()}")

print('Unsealing Vault ...')

unseal_response = vault_client.sys.submit_unseal_keys(keys)

print(f"Vault is Unsealed: {not vault_client.sys.is_sealed()}")

if unseal_response
