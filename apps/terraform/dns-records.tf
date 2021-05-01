resource "cloudflare_record" "dev_ingress_records" {
  for_each = var.dev_sub_domains

  zone_id = var.cloudflare_zone_id
  name    = each.value["subdomain"]
  value   = "locmai.dev"
  type    = "CNAME"
  proxied = true
}

resource "kubernetes_ingress" "dev_ingresses" {
  for_each = var.dev_sub_domains

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