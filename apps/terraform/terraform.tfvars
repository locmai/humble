cloudflare_email = "locmai0201@gmail.com"

prod_domain = "maibaloc.com"

cloudflare_zone_id = "7ca29071dbe54a078c0fbf643d3c0923"

cloudflare_zone_prod_id = "54464d6437d5b02346a086b882bed154"

prod_sub_domains = {}

dev_sub_domains = {
    keycloak = {
        annotations  = {}
        namespace    = "apps"
        service_name = "keycloak-http"
        service_port = 80
        subdomain    = "keycloak"
    },
    oanquan = {
        annotations  = {}
        namespace    = "apps"
        service_name = "o-an-quan-fe"
        service_port = 3000
        subdomain    = "oanquan"
    },
    oanquanapi = {
        annotations  = {}
        namespace    = "apps"
        service_name = "o-an-quan-be"
        service_port = 3003
        subdomain    = "oanquan-api"
    },
}
