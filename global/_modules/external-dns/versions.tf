terraform {
  required_version = ">= 1.0.0"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 4.40.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.32.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 3.4.0"
    }
  }
}
