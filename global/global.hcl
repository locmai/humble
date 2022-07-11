locals {
    environment = split("/",path_relative_to_include())[0]
}

remote_state {
    backend = "kubernetes"

    config = {
        secret_suffix    = "tfstate"
        config_path      = "${get_repo_root()}/metal/kubeconfig.${local.environment}.yaml"
    }

    generate = {
        path      = "kubernetes_backend.tf"
        if_exists = "overwrite_terragrunt"
    }
}

generate "provider" {
  path = "kubernetes_provider.tf"
  if_exists = "overwrite_terragrunt"
  contents = <<EOF
provider "kubernetes" {
  config_path ="${get_repo_root()}/metal/kubeconfig.${local.environment}.yaml"
}
EOF
}

terraform {
    extra_arguments "variables" {
        commands = get_terraform_commands_that_need_vars()

        optional_var_files = [
            find_in_parent_folders("${local.environment}.tfvars")
        ]
    }
}

retryable_errors = [
    "(?s)Error: Failed to download module.*"
]
