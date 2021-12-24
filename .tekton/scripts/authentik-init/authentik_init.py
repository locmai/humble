base_url = "https://authentik.maibaloc.com/api/v3"
api_oauth2_flow = f"{base_url}/instances/?designation=authorization&ordering=slug"
api_oauth2 = f"{base_url}/providers/oauth2/"
test_api =f"{base_url}/flows/bindings/"
payload = {
    'name': "gitea",
    'authorization_flow': None,
    'client_type':  "confidential",
    'client_id': None, 
    'client_secret': None,
    'access_code_validity': 'minutes=1',
    'token_validity': 'days=30',
}

from kubernetes import client, config
import base64
import sys
config.load_kube_config(config_file='../../../metal/kubeconfig.yaml')

v1 = client.CoreV1Api()
ak_admin_token_encoded = v1.read_namespaced_secret("authentik-aka-secret", "platform").data['ak_admin_token']

ak_admin_token = (base64.b64decode(ak_admin_token_encoded)).decode()

print(ak_admin_token)

import requests

res = requests.get(test_api,headers={'Authorization': f"Bearer {ak_admin_token}"})

print(res.status_code)

print(res.json())

# Kubernetes client

# Get Token from secret

# Get the default-provider-authorization-explicit-consent flow from /flows/bindings/