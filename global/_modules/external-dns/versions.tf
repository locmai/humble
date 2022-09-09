terraform {
  required_version = "~> 1.2.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.23.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.13.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.1.0"
    }
  }
}
