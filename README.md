## Humble Project

This repository contains the code for personal infrastructure workspaces and application deployments.

## Overview

The project is inspired by my co-worker's works - [Khue's homelab](https://github.com/khuedoan/homelab)

## Usage

### Prerequisite

For the controller:
- SSH keys in ~/.ssh/{id_rsa,id_rsa.pub}
- terraform (0.14.5 or above)
- ansible & python3
- make

For bare metal nodes:
- Internet connection
- openssh installed

### Building the layer
```sh
make metal
make infras
kubectl create secret generic -n metallb-system memberlist --from-literal=secretkey="$(openssl rand -base64 128)"
make platform
make apps
```

## Layered Stack

- Each layer uses an isolated tfstate.
- The above layers (layers with higher order) could be depended on the lower layers.
- Other shared components must be able for versioning and configurable (with custom data/parameters)

### Layer 0 - Metal

- NEC servers
- Local SSH keys
- Local packages
- CloudFlare DDNS
- Netdata Agent

### Layer 1 - Infrastructure

- **Workload Orchestrator:** RKE clusters
- **Networking:** MetalLB with Nginx Ingress
- **Storage Management:** Longhorn
- **Secret Management:** Vault

### Layer 2 - Platform

- **Source Version Control:** GitHub
- **Continuous Delivery:** ArgoCD, Keel
- **Observability** Grafana, Prometheus, Loki, Jaeger, etc.

### Layer 3 - Applications

- Black Ping
- Yuta Reborn
- Personal Blog

#### Notes:
(1) All provisioned by Terraform and configured by Ansible
(2) All provisioned and configured by ArgoCD with GitHub

[Progress checklist](https://github.com/locmai/humble/blob/main/docs/checklist.md)

## Folder Structure

```
tree -L 2
.
├── Makefile
├── README.md
├── apps
│   ├── Makefile
│   ├── README.md
│   └── argocd
├── docs
│   ├── README.md
│   └── checklist.md
├── infras
│   ├── Makefile
│   ├── ansible
│   └── terraform
├── metal
│   └── ansible
├── platform
│   ├── Makefile
│   ├── README.md
│   ├── argocd
│   └── terraform
├── scripts
│   └── README.md
└── tests
    └── volumes
```

- Root directories divided by the layers and 
- Inside each layer directory, the folders will be divided based on the provisioner (terraform, argocd, ansible, etc.)

