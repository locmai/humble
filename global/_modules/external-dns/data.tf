data "cloudflare_zone" "main_domain_name" {
  name = var.main_domain_name
}

data "cloudflare_api_token_permission_groups" "all" {}

