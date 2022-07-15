Please refer to the [configuration per deployment](/concepts/configuration-per-deployment/) guide for multiple production deployments and more advanced setup.

For a single production deployment, the following settings are required for getting started.

## Domain

The setting for the main domain that would be used for all ingresses located at {root}/bootstrap/values-<env>.yaml.

```yaml
# example: humble/bootstrap/values-prod.yaml
global:
  domain: "maibaloc.com"
```

Set the `global.domain` value to the domain that you own.

## Inventory

The collection of metal nodes we utilized for the Ansible will need to be defined. Update the './metal/inventories/<env>.yml' file with the information you got in the previous step:

```yaml
# example: ./metal/inventories/prod.yml
metal:
  children:
    masters:
      hosts:
        prod00: {ansible_host: <desired_ip_0>, mac: '<mac_address_0>', disk: sda, network_interface: eno1}
        prod01: {ansible_host: <desired_ip_1>, mac: '<mac_address_1>', disk: sda, network_interface: eno1}
        prod02: {ansible_host: <desired_ip_2>, mac: '<mac_address_2>', disk: sda, network_interface: eno1}
    workers:
      hosts:
        {}
  vars:
    env: prod
```

## Cloudflare Terraform provider

We use the [Cloudflare provider](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs) for creating Tunnel resources and secrets.

After signing up and logging into your Cloudflare account, generate the API token by access to this page https://dash.cloudflare.com/profile/api-tokens and then create a token with the following permissions:

- All accounts - Argo Tunnel:Edit, Access: Service Tokens:Edit, Access: Organizations, Identity Providers, and Groups:Edit, Access: Apps and Policies:Edit
- All zones - Zone Settings:Edit, Zone:Edit, DNS:Edit

You can now set all the required inputs in the `./global/<env>.tfvars`:

```
cloudflare_account_id = "<cloudflare_account_id>"

cloudflare_api_key = "<generated_token>"

cloudflare_email = "<your_cloudflare_email>"
```

## Applications

The setups for all applications are straightforward and basic in general; they are all defined in YAML format (in the values.yaml files) and are comparable in nature.

Take Istio deployment as an example:

```yaml
istio:
  enabled: true
  namespace: istio-system
  gateway:
    enabled: false
```

The above configuration indicates that we want Istio to be deployed in the 'istio-system' namespace without the Istio gateway.

