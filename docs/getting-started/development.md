--8<--
./docs/templates/development.md
--8<--

## Prerequisites

### Install the required tools

--8<--
./docs/templates/required-tools.md
--8<--

### Recommended hardware specification

- Operating System: Linux or macOS
- CPUs: 4 cores
- Memory: 16 GiB

## Build

Simply clone the repository

```sh
git clone https://github.com/locmai/humble
```

### Build with tools container

For getting started with the tools container run the following `make` commands:

```shell
make tools
```

**OR** with just the nix-shell:

```
nix develop
```

Then spin up the development environment:

```
make dev
```

## Explore

By default, the domain for development would leverage [nip.io](https://nip.io) for local DNS resolution. So we could start with accessing the [argocd.172-28-0-3.nip.io](https://argocd.172-28-0-3.nip.io).

Get the ArgoCD admin password with the script:

```sh
./tools/argocd-password
```

From there, you could have an overview of things those got deployed.

Grafana integrated with OIDC authentication is provided as well. Access Grafana at [grafana.172-28-0-3.nip.io](https://grafana.172-28-0-3.nip.io) and sign in with Vault.

Get the Vault admin password with the script:

```sh
./tools/admin-password
```

## Clean up

Simply delete the cluster and remove the generated kubeconfig:

```
k3d cluster delete humble-dev
rm ./metal/kubeconfig.prod.yaml
```
