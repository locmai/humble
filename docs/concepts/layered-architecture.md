The idea behind Layered Architecture is that modules or components with similar functionalities are organized into horizontal layers. As a result, each layer is responsible for a specific set of resources grouped by the domain. And the higher layers will depend on the lower layers.

Imagine a building that stacked up by the following layers:

```
+--------------+
|   ./global   |
|--------------|
|    ./apps    |
|--------------|
|  ./platform  |
|--------------|
|   ./system   |
|--------------|
| ./bootstrap  |
|--------------|
|   ./metal    |
|--------------|       +--------------+
|   hardware   |- - - -|  controller  |
+--------------+       +--------------+
```

Main layers are structured in the following directories:

- `./metal`: bare metal management, install Linux and Kubernetes.
- `./bootstrap`: GitOps bootstrap with ArgoCD.
- `./system`: critical system components for the cluster (load balancer, storage, ingress, -operation tools...).
- `./platform`: shared services for the `apps` components to utilize on.
- `./apps`: user facing applications or services/
- `./global` (optional): public-facing managed services including the Cloudflare provisioning and DNS setup.


Support components:

- `./tools`: tools container, includes all the tools and scripts you'll need for operations.
- `./docs`: all documentation go here, this will generate a searchable web UI.
