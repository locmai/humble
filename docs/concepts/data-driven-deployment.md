---
title: Data-driven deployment strategy
---

## Configuration hierarchy

Each deployment is configured using its own YAML files and shared ones. As a result, you can configure each deployment uniquely or have the same configuration across all deployments.

The directory structure with the configuration files:


```yaml
bootstrap/root:      # top-level configuration for all ArgoCD layers
  - values-dev.yaml  # deployment-level override configuration
  - values-stag.yaml
  - values-prod.yaml
  - values.yaml      # shared configuration
global:
  - values-dev.yaml  # deployment-and-layer-level override configuration
  - values-stag.yaml
  - values-prod.yaml
  - values.yaml      # layer-level shared configuration
  - prod.tfvars      # terraform variable definitions files
  - stag.tfvars 
apps:
  - values-dev.yaml
  - values-stag.yaml
  - values-prod.yaml
platform:
  - ...              # same set of files in the apps directory
system:
  - ... 
metal/inventories:   # top-level configuration for metal layer
  - dev.yml
  - prod.yml
  - stag.yml
```

We could update the settings in the proper configuration files based on the needs to configure either the specific layer, a deployment, or from the top level.

## Configure with branches

Leverage the configuration-as-code practices, we can configure the code with Git branches as well - adding another configuration level.

Each ArgoCD application has a `targetRevision` field to target a revision (tag/branch/commit) of the repository 

With that in place, we could dynamically configure an application with different revisions of the `values-<env>.yaml` files with the ability to test/develop/revert the changes real quick.
