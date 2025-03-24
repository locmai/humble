terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 5.2.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.36.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.4.0"
    }
  }
}
