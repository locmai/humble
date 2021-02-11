resource "rke_cluster" "cluster" {

  cluster_name = "cluster"

  cluster_yaml = file("cluster.yaml")

  # Yes, ignoring the Docker version, I live dangerously
  ignore_docker_version = true

  dynamic "nodes" {
    for_each = local.nodes

    content {
      address = nodes.value.id
      user    = local.ssh_user
      role    = nodes.value.roles
      ssh_key = local.ssh_key
    }
  }

  ingress {
    provider = "none"
  }

  upgrade_strategy {
    drain                  = true
    max_unavailable_worker = "25%"

    drain_input {
      ignore_daemon_sets = true
      timeout            = 600
    }
  }

  addons_include = [
    "https://raw.githubusercontent.com/istio/istio/release-1.9/samples/addons/prometheus.yaml",
    "https://raw.githubusercontent.com/istio/istio/release-1.9/samples/addons/grafana.yaml",
  ]
}

resource "local_file" "kube_config_yaml" {
  filename = "${path.root}/kube_config.yml"
  content  = rke_cluster.cluster.kube_config_yaml
}
