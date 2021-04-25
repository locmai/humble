longhorn_enabled = true

monitoring_enabled = false

vault_enabled = true

cloudflare_email = "locmai0201@gmail.com"

dev_domain = "locmai.dev"

cloudflare_zone_id = "7ca29071dbe54a078c0fbf643d3c0923"

dev_sub_domains = {
    argo = {
        annotations  = {}
        namespace    = "argocd"
        service_name = "argocd-server"
        service_port = 80
        subdomain    = "argocd"
    },
    vault = {
        annotations  = {}
        namespace    = "vault"
        service_name = "vault-ui"
        service_port = 8200
        subdomain    = "vault"
    }
}

platform_sub_domains = {}