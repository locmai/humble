locals {
  nodes    = yamldecode(file("nodes.yaml"))
  ssh_user = "locmai"
  ssh_key  = file("~/.ssh/id_rsa_lmlabs")

  monitoring_namespace = "monitoring"
}
