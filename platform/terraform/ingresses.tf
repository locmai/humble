resource "kubernetes_ingress" "dev_platform_ingresses" {
  depends_on = [rke_cluster.cluster]

  for_each = var.dev_platform_sub_domains

  metadata {
    name        = "${each.value["subdomain"]}-ingress"
    namespace   = each.value["namespace"]
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

