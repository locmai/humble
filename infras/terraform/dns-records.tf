resource "cloudflare_record" "dev_root_record" {
  zone_id = var.cloudflare_zone_id
  name    = "locmai.dev"
  // Random IP, real IP will be managed by DDNS
  value   = "12.34.56.78"
  type    = "A"
  proxied = true

  lifecycle {
    ignore_changes = [
      value,
    ]
  }
}

resource "cloudflare_record" "dev_www_record" {
  zone_id = var.cloudflare_zone_id
  name    = "www"
  value   = "locmai.dev"
  type    = "CNAME"
  proxied = true
}

resource "cloudflare_record" "dev_status_record" {
  zone_id = var.cloudflare_zone_id
  name    = "ping"
  value   = "statuspage.betteruptime.com"
  type    = "CNAME"
  proxied = false
}

resource "cloudflare_record" "dev_ingress_records" {
  for_each = var.dev_sub_domains

  zone_id = var.cloudflare_zone_id
  name    = each.value["subdomain"]
  value   = "locmai.dev"
  type    = "CNAME"
  proxied = true
}