variable "default_namespace" {
    type = string
    default = "apps"
}

variable "cloudflare_email" {
  type = string
}

variable "dev_domain" {
  type = string
}

variable "prod_domain" {
  type = string
}

variable "cloudflare_zone_id" {
  type = string
}

variable "cloudflare_zone_prod_id" {
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

variable "prod_sub_domains" {
  type = map(object({
    annotations  = map(any)
    namespace    = string
    service_name = string
    service_port = number
    subdomain    = string
  }))
  default = {}
}