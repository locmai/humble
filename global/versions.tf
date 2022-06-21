terraform {
  required_version = "~> 1.2.0"

  backend "kubernetes" {
    secret_suffix    = "tfstate"
    config_path      = "${path.root}/../metal/kubeconfig.${var.env}.yaml"
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.15.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.11.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 2.1.0"
    }
  }
}
