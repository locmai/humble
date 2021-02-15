resource "helm_release" "longhorn" {
  count            = var.longhorn_enabled ? 1 : 0
  name             = "longhorn"
  repository       = "https://charts.longhorn.io"
  chart            = "longhorn"
  namespace        = "longhorn"
  create_namespace = true
}

resource "helm_release" "consul" {
  depends_on       = [helm_release.longhorn]
  count            = var.vault_enabled ? 1 : 0
  name             = "consul"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "consul"
  namespace        = "vault"
  create_namespace = true
}

resource "helm_release" "vault" {
  depends_on       = [helm_release.longhorn, helm_release.consul]
  count            = var.vault_enabled ? 1 : 0
  name             = "vault"
  repository       = "https://helm.releases.hashicorp.com"
  chart            = "vault"
  namespace        = "vault"
  create_namespace = true
  values = [
    file("helm-values/vault.yaml")
  ]

  set {
    name  = "server.ha.enabled"
    value = "true"
  }
}

resource "helm_release" "nginx" {
  name       = "nginx"
  repository = "https://kubernetes.github.io/ingress-nginx"
  chart      = "ingress-nginx"
  version    = "3.10.1"

  namespace        = "nginx"
  create_namespace = true

  values = [
    file("helm-values/nginx-ingress.yaml")
  ]
}

resource "helm_release" "argocd" {
  // Depends on Nginx Ingress for ArgoCD Web UI
  depends_on = [helm_release.nginx]

  name             = "argocd"
  repository       = "https://argoproj.github.io/argo-helm"
  chart            = "argo-cd"
  namespace        = "argocd"
  create_namespace = true

  values = [
    file("helm-values/argocd.yaml")
  ]
}

resource "helm_release" "monitoring" {
  depends_on       = [helm_release.longhorn]
  count            = var.monitoring_enabled ? 1 : 0
  name             = "monitoring"
  repository       = "https://prometheus-community.github.io/helm-charts"
  chart            = "kube-prometheus-stack"
  namespace        = "monitoring"
  create_namespace = true

  // Disabled values from yaml. (including persistent for prometheus and grafana)
  // values = [
  //   file("helm-values/monitoring.yaml")
  // ]

  // set {
  //   name  = "valuesChecksum"
  //   value = filemd5("helm-values/monitoring.yaml")
  // }
}

resource "kubernetes_config_map" "default-metallb-config" {
  depends_on = [rke_cluster.cluster]

  metadata {
    name      = "config"
    namespace = "metallb-system"
  }

  data = {
    config = <<EOF
        address-pools:
        - name: default-pool
          protocol: layer2
          addresses:
          - 192.168.1.100-192.168.1.200
        EOF
  }
}

resource "kubernetes_ingress" "dev_ingresses" {
  for_each = var.dev_sub_domains

  metadata {
    name      = "${each.value["subdomain"]}-ingress"
    namespace = each.value["namespace"]
    annotations = each.value["annotations"]
  }

  spec {
    rule {
      host = "${each.value["subdomain"]}.${var.dev_domain}"
      http {
        path {
          backend {
            service_name = each.value["service_name"]
            service_port = each.value["service_port"]
          }
        }
      }
    }
  }
}