default:
	terraform apply -auto-approve

cleanup:
	terraform state rm kubernetes_secret.cert_manager_token
	terraform state rm kubernetes_secret.cloudflared_credentials
	terraform state rm kubernetes_secret.external_dns_token
