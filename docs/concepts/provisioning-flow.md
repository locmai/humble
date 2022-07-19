!!! note "Acknowledgement"

    Cloned from provisioning flow in [khuedoan/homelab/reference/architecture](https://homelab.khuedoan.com/reference/architecture/)

Everything is automated, after you edit the configuration files, you just need to run a single `make` command and it will:

- (1) Build the `./metal` layer:
    - Create an ephemeral, stateless PXE server
    - Install Linux on all servers in parallel
    - Build a Kubernetes cluster (based on k3s)
- (2) Build the `./bootstrap` layer:
    - Install ArgoCD
    - Configure the root app to manage other layers (and also manage itself)

From now on, ArgoCD will do the rest:

- (3) Build the `./system` layer (storage, networking, monitoring, etc)
- (4) Build the `./platform` layer (Gitea, Vault, etc)
- (5) Build the `./apps` layer: (Dashy, Yuta, Dendrite, etc)
- (6) Build the `./global` layer: (Cloudflare and stuffs)

```mermaid
%%{init: { "flowchart": { "htmlLabels": true, "curve": "linear" } } }%%
flowchart TD
  subgraph metal[./metal]
    pxe[PXE Server] --> linux[Fedora Server] --> k3s
  end

  subgraph bootstrap[./bootstrap]
    argocd[ArgoCD] --> rootapp[Root app]
  end

  subgraph system[./system]
    metallb[MetalLB]
    nginx[NGINX]
    longhorn[Longhorn]
    cert-manager
    external-dns[External DNS]
    cloudflared
  end

  subgraph platform
    gitea[Gitea]
    tekton[Tekton]
    vault[Vault]
  end

  subgraph apps
    yuta[Yuta]
    matrix[Matrix]
    dashy[Dashy]
  end

  subgraph global[./global]
    letsencrypt[Let's Encrypt]
    cloudflare[Cloudflare]
  end

  letsencrypt -.-> cert-manager
  cloudflare -.-> external-dns
  cloudflare -.-> cloudflared


  
  make[Run make] -- 1 --> metal -- 2 --> bootstrap -- 3 --> system -- 4 --> platform -- 5 --> apps
  make[Run make] -- 6 --> global
```
