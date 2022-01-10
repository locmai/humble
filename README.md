# Humble Project

![argocd status](https://argocd.maibaloc.com/api/badge?name=root&revision=true)
[![License: GPL v3](https://img.shields.io/badge/License-GPLv3-blue.svg)](https://www.gnu.org/licenses/gpl-3.0)

## Overview

Humble is a project that seeks to set up a ready-to-go environment with operating services using modern infrastructure as code with GitOps driven.

## Features

### Single-node cluster

- [x] Single command to spin up a single-node cluster

### Production-grade cluster

- [x] Bare-metal setup
  - [x] OS installation from PXE boot
  - [x] Init configuration
- [x] Everything as code
- [x] Automation-first approach
- [x] Functional cluster powered by k3s
- [x] Common infrastructures and services
  - [x] Load balancers / Ingress controller
  - [x] Secured internal and external DNS setup
  - [x] Cloud native distributed block storage
  - [x] Secret management system
  - [x] Messaging platform
  - [x] Remove SVC server
  - [x] Service Mesh with Istio
- [ ] IAM system
  - [x] Identity platform
  - [ ] SSO login
  - [ ] RBAC managment
- [x] Continuous Integration and Delivery
  - [x] ArgoCD - GitOps
  - [x] GitHub Action
  - [x] Argo Workflow
  - [ ] Private Container Registry
  - [ ] Private Package Registry
- [x] Observability
  - [x] Operating dashboards
  - [x] Log streaming
  - [ ] Alert rules and notifications
  - [x] Distributed tracing
- [ ] Demo services
  - [ ] [Saleor](https://saleor.io/)
  - [ ] [microservices-demo](https://github.com/locmai/microservices-demo)

## Matrix server

If you have further questions, please feel free to join us at:

- **[#homelab](https://matrix.to/#/#homelab:dendrite.maibaloc.com)** - General chat about the Humble project, for users and server admins alike
- **[#humble-dev](https://matrix.to/#/#humble-dev:dendrite.maibaloc.com)** - The place for developers, where all Dendrite development discussion happens
- **[#alerts](https://matrix.to/#/#alerts:dendrite.maibaloc.com)** - Release/incident notifications and important info, highly recommended for all Dendrite server admins

Or by creating an account at **[chat.maibaloc.com](https://chat.maibaloc.com)**

## Technology Landscape

TBD

## Usage

See the [docs](https://humble.maibaloc.com) for detailed information on the architecture, installation and use of the platform.

## Acknowledgements

- A lot of great works from my [co-worker's homelab](https://github.com/khuedoan/homelab)
- Awesome services from CloudFlare: DNS, Pages and Tunnel. The document of this project is hosted on CloudFlare as well.

