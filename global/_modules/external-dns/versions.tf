terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.5.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.37.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.5.0"
    }
  }
}
