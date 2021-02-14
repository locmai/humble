## Humble Project

Infrastructures and Application Deployments as Code repository.

## Overview

TBD

## Layer Stack:

- Each layer will use an isolated tfstate.
- The above layers (layers with higher order) could be depended on the lower layers.
- Other shared components must be able for versioning and configurable (with custom data/parameters)

### Layer 0: Metal/Genesis

- NEC servers
- Local SSH keys
- Local packages
- (*) Local: the original content initialized from the laptop.

### Layer 1 - all provisioned by Terraform and configured by Ansible:

- RKE clusters
- Network: MetalLB with Nginx Ingress
- Storage: Longhorn

### Layer 2: Platform

- GitHub
- ArgoCD
- Vault
- Monitoring: Grafana + Prometheus
- Logging: Grafana + Loki