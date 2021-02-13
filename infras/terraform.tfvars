# PV
longhorn_enabled = true

monitoring_enabled = true

vault_enabled = true

default_pool = "192.168.1.66-192.168.1.69"

cloudflare_email = "locmai0201@gmail.com"

cloudflare_zone_id = "6544fae6badbb52ecd81ba920a4e33e0"

dev_domain = "locmai.dev"

dev_sub_domains = {
  argocd = {
    namespace    = "argocd"
    service_name = "argocd-server"
    service_port = 80
    subdomain    = "argocd"
  }
}