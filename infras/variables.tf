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

variable "default_pool" {
  type = string
}