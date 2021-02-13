resource "cloudflare_record" "dev_records" {
  for_each = var.dev_sub_domains

  zone_id = var.cloudflare_zone_id
  name    = each.value["subdomain"]
  value   = "locmai.dev"
  type    = "CNAME"
  ttl     = 3600
}