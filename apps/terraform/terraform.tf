terraform {
  required_version = "= 0.14.5"

  required_providers {
    vault = {
      version = ">= 2.0.2"
      source  = "hashicorp/vault"
    }
  }
}
