data "kubernetes_service" "default_kubernetes_service" {
  metadata {
    name = "kubernetes"
    namespace = "default"
  }
}

data "kubernetes_service_account" "vault_vault" {
  metadata {
    name = "vault"
    namespace = "vault"
  }
}

data "kubernetes_secret" "vault_vault_token" {
  metadata {
    name = data.kubernetes_service_account.vault_vault.default_secret_name
    namespace = "vault"
  }
}