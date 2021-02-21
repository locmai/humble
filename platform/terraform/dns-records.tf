resource "cloudflare_record" "dev_platform_ingress_records" {
  for_each = var.dev_platform_sub_domains

  zone_id = var.cloudflare_zone_id
  name    = each.value["subdomain"]
  value   = "locmai.dev"
  type    = "CNAME"
  proxied = true
}