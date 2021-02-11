resource "helm_release" "longhorn" {
  count            = var.longhorn_enabled ? 1 : 0
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  namespace        = "longhorn"
  create_namespace = true
}