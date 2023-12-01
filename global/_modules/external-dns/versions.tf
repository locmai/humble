terraform {
  required_version = "~> 1.4.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.20.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.20.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.3.0"
    }
  }
}
