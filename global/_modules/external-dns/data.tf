data "cloudflare_zone" "main_domain_name" {
  name = var.main_domain_name
}

data "cloudflare_api_token_permission_groups" "all" {}

data "http" "public_ipv4" {
  url = "https://ipv4.icanhazip.com"
}

data "http" "public_ipv6" {
  url = "https://ipv6.icanhazip.com"
}
