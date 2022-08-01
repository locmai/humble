terraform {
  required_version = "~> 1.2.0"

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
      version = "~> 3.0.0"
    }
  }
}
