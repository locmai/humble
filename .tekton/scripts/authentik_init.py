api_oauth2_flow = "https://authentik.maibaloc.com/api/v3/flows/instances/?designation=authorization&ordering=slug"
api_oauth2 = "https://authentik.maibaloc.com/api/v3/providers/oauth2/"
payload = {
    'name': "gitea",
    'authorization_flow': None,
    'client_type':  "confidential",
    'client_id': None, 
    'client_secret': None,
    'access_code_validity': 'minutes=1',
    'token_validity': 'days=30',
}