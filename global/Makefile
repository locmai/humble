default:
	terraform apply -auto-approve

# TODO figure on cleaning this up without Kubernetes stuff
cleanup:
	terraform state rm kubernetes_secret.cert_manager_token
	terraform state rm kubernetes_secret.cloudflared_credentials
	terraform state rm kubernetes_secret.external_dns_token
	terraform state rm 'kubernetes_namespace.namespaces["cert-manager"]'
	terraform state rm 'kubernetes_namespace.namespaces["cloudflared"]'
	terraform state rm 'kubernetes_namespace.namespaces["external-dns"]'
	terraform state rm 'kubernetes_namespace.namespaces["tekton-pipelines"]'
