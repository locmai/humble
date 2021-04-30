provider "vault" {
    address = "https://vault.locmai.dev"
}

provider "kubernetes" {
  config_path = "../../infras/terraform/kube_config.yml"
}
