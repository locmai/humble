# Operational services

## List of services

| Name               | Description                                                                    | Default URL             | Login type  |
| ------------------ | -------------------------------------------------------------------------------| ----------------------- | ----------  | 
| ArgoCD             | To manage all ArgoCD applications                                              | argocd.maibaloc.com     | `argocd`    |
| Grafana            | To view telemetry data from Prometheus and Loki                                | grafana.maibaloc.com    | `dex` |

## Getting admin credentials

### ArgoCD

For `argocd` login type, to get the admin credential, run:

```
./tools/argocd-password
```

Then login as `admin` with the password.

