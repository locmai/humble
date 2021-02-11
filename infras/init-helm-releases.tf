resource "helm_release" "longhorn" {
  count            = var.longhorn_enabled ? 1 : 0
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  namespace        = "longhorn"
  create_namespace = true
}

resource "helm_release" "vault" {
  count            = var.vault_enabled ? 1 : 0
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
  create_namespace = true
}
