locals {
  nodes    = yamldecode(file("hosts.yaml"))["all"]["children"]["nodes"]["hosts"]

  ssh_user = "locmai"
  ssh_key  = file("~/.ssh/id_rsa_lmlabs")

  monitoring_namespace = "monitoring"
}
