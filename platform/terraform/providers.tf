provider "rke" {
  debug    = true
  log_file = "rke_debug.log"
}

provider "kubernetes" {
  config_path = "../../infras/terraform/kube_config.yml"
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_token = var.cloudflare_api_token
}
