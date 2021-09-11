cloudflare_email = "locmai0201@gmail.com"

dev_domain = "locmai.dev"

cloudflare_zone_id = "7ca29071dbe54a078c0fbf643d3c0923"

dev_platform_sub_domains = {
    grafana = {
        annotations  = {}
        namespace    = "monitoring"
        service_name = "monitoring-grafana"
        service_port = 80
        subdomain    = "grafana"
    },
    sonarqube = {
        annotations  = {}
        namespace    = "sonarqube"
        service_name = "sonarqube-sonarqube"
        service_port = 9000
        subdomain    = "sonarqube"
    }
}