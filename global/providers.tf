provider "cloudflare" {
  email   = var.cloudflare_email
  api_key = var.cloudflare_api_key
}

provider "kubernetes" {
  config_path = "${path.root}/../metal/kubeconfig.${var.env}.yaml"
}
