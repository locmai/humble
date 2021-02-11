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