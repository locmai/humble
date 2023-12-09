terraform {
  required_version = "~> 1.6.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.20.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.24.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.4.0"
    }
  }
}
