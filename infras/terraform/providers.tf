provider "rke" {
  debug    = true
  log_file = "rke_debug.log"
}

provider "helm" {
  kubernetes {
    config_path = local_file.kube_config_yaml.filename
  }
}

provider "kubernetes" {
  config_path = local_file.kube_config_yaml.filename
}

provider "cloudflare" {
  email     = var.cloudflare_email
  api_token = var.cloudflare_api_token
}

# Configure the GitHub Provider
provider "github" {
  owner = var.github_owner
}