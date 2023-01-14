# Operational services

## List of services

| Name               | Description                                                                    | Default URL             | Login type  |
| ------------------ | -------------------------------------------------------------------------------| ----------------------- | ----------  | 
| ArgoCD             | To manage all ArgoCD applications                                              | argocd.maibaloc.com     | `argocd`    |
| Grafana            | To view telemetry data from Prometheus and Loki                                | grafana.maibaloc.com    | `vault_sso` |
| Vault              | To manage secrets, credentials, and act as the identity provider for SSO login | auth.maibaloc.com       | `vault_sso` |
| Argo Workflows     | To manage workflows                                                            | workflows.maibaloc.com  | `vault_sso` |

## Getting admin credentials

### ArgoCD

For `argocd` login type, to get the admin credential, run:

```
./tools/argocd-password
```

Then login as `admin` with the password.

## Vault SSO

For `vault_sso` login type, to get the admin credential, run

```
./tools/admin-password
```

Then login as `admin` with the password. Once you logged in, the other services with `vault_sso` setup will be logged in with the same admin credential as well.