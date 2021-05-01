resource "vault_auth_backend" "kubernetes" {
  type = "kubernetes"
}

resource "vault_kubernetes_auth_backend_config" "default_kubernetes_auth_backend_config" {
  backend                = vault_auth_backend.kubernetes.path
  kubernetes_host        = "https://${data.kubernetes_service.default_kubernetes_service.spec[0].cluster_ip}:443"
  kubernetes_ca_cert     = data.kubernetes_secret.vault_vault_token.data["ca.crt"]
  token_reviewer_jwt     = data.kubernetes_secret.vault_vault_token.data["token"]
}


