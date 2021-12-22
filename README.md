# Humble Project

## Overview

Humble is a project that seeks to set up a ready-to-go environment with operating services using modern infrastructure as code with GitOps driven.

## Features

### Single-node cluster

- [ ] Single command to spin up a single-node cluster

### Production-grade cluster

- [x] Bare-metal setup
  - [x] OS installation from PXE boot
  - [x] Init configuration
- [x] Everything as code
- [x] Common infrastructures and services
  - [x] Load balancers / Ingress controller
  - [x] Cloud native distributed block storage(longhorn.io)
  - [x] Secret management system
  - [ ] Mail server
  - [ ] Messaging platform
- [ ] IAM system
  - [ ] Identity platform
  - [ ] SSO login
  - [ ] RBAC managment
- [x] Continuous Integration and Delivery
  - [x] ArgoCD - GitOps
  - [x] GitHub Action
  - [x] Argo Workflow
- [ ] Observability
  - [x] Operating dashboards
  - [x] Log streaming
  - [ ] Alert rules and notifications
  - [ ] Distributed tracing
- [ ] Demo services
  - [ ] Saleor

## Technology Landscape

TBD

## Usage

See the docs for detailed information on the architecture, installation and use of the platform.

## Acknowledgements

- A lot of great works from my [co-worker's homelab](https://github.com/khuedoan/homelab)

