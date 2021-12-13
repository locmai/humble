terraform {
  required_version = "~> 1.1.0"

  backend "remote" {
    hostname     = "app.terraform.io"
    organization = "lmlabs"

    workspaces {
      name = "humble-global"
    }
  }

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "~> 3.4.0"
    }

    kubernetes = {
      source = "hashicorp/kubernetes"
      version = "~> 2.7.0"
    }

    http = {
      source = "hashicorp/http"
      version = "~> 2.1.0"
    }
  }
}