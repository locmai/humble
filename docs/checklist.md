## Layered Stack

- Each layer will use an isolated tfstate.
- The above layers (layers with higher order) could be depended on the lower layers.
- Other shared components must be able for versioning and configurable (with custom data/parameters)

### Layer 0 - Metal

- [x] NEC servers
- [x] Local SSH keys
- [x] Local packages
- [x] CloudFlare DDNS
- [x] Netdata Agent

### Layer 1 - all provisioned by Terraform and configured by Ansible:

- [x] RKE clusters
- [x] Network: MetalLB with Nginx Ingress
- [x] Storage: Longhorn
- [x] Vault

### Layer 2 - Platform

- [x] GitHub
- [x] ArgoCD
- [x] Observability
  - [x] Prometheus
  - [x] Graphite
  - [x] Grafana
  - [x] Loki
- [ ] Performance synthesis:
  - [ ] Locust
  - [ ] Sitespeed.io

### Layer 3 - Applications

- [ ] Black Ping
- [ ] Yuta Reborn
- [x] Personal Blog