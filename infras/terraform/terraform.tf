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

    cloudflare = {
      version = ">= 2.0"
      source  = "cloudflare/cloudflare"
    }

    github = {
      version = ">= 4.9.3"
      source  = "hashicorp/github"
    }
  }
}