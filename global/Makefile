default:
	terraform init -upgrade
	terraform apply -auto-approve

# TODO figure on cleaning this up without Kubernetes stuff
cleanup:
	terraform state rm kubernetes_secret.cert_manager_token
	terraform state rm kubernetes_secret.cloudflared_credentials
	terraform state rm kubernetes_secret.external_dns_token
