terraform {
  required_version = "= 0.14.5"

  required_providers {
    rke = {
      version = ">= 1.1.7"
      source  = "rancher/rke"
    }

    helm = {
      version = ">= 2.0.2"
      source  = "hashicorp/helm"
    }
  }
}
