variable "github_owner" {
  type = string
  default = "locmai"
}

variable "longhorn_enabled" {
  type    = bool
  default = false
}

variable "monitoring_enabled" {
  type    = bool
  default = false
}

variable "vault_enabled" {
  type    = bool
  default = false
}

variable "cloudflare_email" {
  type = string
}

variable "dev_domain" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_api_token" {
  type = string
}

variable "dev_sub_domains" {
  type = map(object({
    annotations  = map(any)
    namespace    = string
    service_name = string
    service_port = number
    subdomain    = string
  }))
  default = {}
}

variable "platform_sub_domains" {
  type = map(object({
    annotations  = map(any)
    namespace    = string
    service_name = string
    service_port = number
    subdomain    = string
  }))
  default = {}
}
