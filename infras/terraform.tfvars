# PV
longhorn_enabled = true

monitoring_enabled = false

vault_enabled = true

cloudflare_email = "locmai0201@gmail.com"

cloudflare_zone_id = "7ca29071dbe54a078c0fbf643d3c0923"

dev_domain = "locmai.dev"

dev_sub_domains = {
  argocd = {
    annotations = {
      "nginx.ingress.kubernetes.io/ssl-passthrough" = "true"
    }
    namespace    = "argocd"
    service_name = "argocd-server"
    service_port = 80
    subdomain    = "argocd"
  },
  grafana = {
    annotations  = {}
    namespace    = "monitoring"
    service_name = "monitoring-grafana"
    service_port = 80
    subdomain    = "grafana"
  }
  vault = {
    annotations  = {}
    namespace    = "vault"
    service_name = "vault-ui"
    service_port = 8200
    subdomain    = "vault"
  }
}