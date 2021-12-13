# pulumi config set cloudflare:tunnel_secret --secret

from secrets import token_urlsafe

print(token_urlsafe(64))