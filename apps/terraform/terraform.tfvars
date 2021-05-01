cloudflare_email = "locmai0201@gmail.com"

dev_domain = "locmai.dev"

cloudflare_zone_id = "7ca29071dbe54a078c0fbf643d3c0923"

dev_sub_domains = {
    keycloak = {
        annotations  = {}
        namespace    = "apps"
        service_name = "keycloak-http"
        service_port = 80
        subdomain    = "keycloak"
    },
}
