## Fork this repository

Because this project applies GitOps practices,
it's the source of truth for _my_ homelab, so you'll need to fork it to make it yours: 

[:fontawesome-solid-code-fork: Fork locmai/humble](https://github.com/locmai/humble){ .md-button--primary}


## Hardware requirements


### Initial controller

The initial controller is the machine used to bootstrap the cluster, we only need it once, you can use your laptop or desktop.

Required tools on the box:

--8<--
./docs/templates/required-tools.md
--8<--

### Servers

The servers are the main master/worker nodes of the deployment. Any modern x86_64 computer(s) should work, you can use old PCs, laptops or servers.

The following specifications are the minimum requirements for _each_ node

| Component  | Minimum | Recommended                                                                                  |
| :--        | :--     | :--                                                                                          |
| CPU        | 2 cores | 4 cores                                                                                      |
| RAM        | 8 GB    | 16 GB                                                                                        |
| Hard drive | 128 GB  | 512 GB                                                                                       |
| Node count | 3       | 3 or more for high availability                                                              |

Additional capabilities:

- Ability to boot from the network (PXE boot)
- Wake-on-LAN capability, used to wake the machines up automatically without physically touching the power button

### BIOS settings
This is something you'll have to perform for all of your servers.

For your convenience, I've included a setting-as-yaml of my BIOS settings. You'll need to adjust it to your hardware because your motherboard may have a different name for the options.

```yaml
Devices:
    NetworkSetup:
    PXEIPv4: true
    PXEIPv6: false
Advanced:
CPUSetup:
    VT-d: true
Power:
AutomaticPowerOn:
    WoL: Automatic  # Use network boot if Wake-on-LAN
Security:
SecureBoot: false
Startup:
CSM: false
```

### Gather information
You may need to gather the following information beforehand for the next step:

- MAC address for each machine (required )
- OS disk name (for example /dev/sda)
- Network interface name (usually, the default should be eth0)
- Arrange the static IP addresses for your machines when they spin up

### Sign up for a Cloudflare account

We also use Cloudflare which is a full-featured DNS and web experience optimization solution. For this setup, all we need is a free account.

So let's sign up for a free [Cloudflare](https://cloudflare.com) account.


### Domain

Buying a domain is required for public access. Follow the [Cloudflare DNS zone setup guide](https://developers.cloudflare.com/dns/zone-setups/full-setup/setup/) to use Cloudflare as your primary DNS provider.

After forking the repository, update your DNS in the following files:

- global/prod/terragrunt.hcl
- bootstrap/root/values-prod.yaml
- bootstrap/argocd/values-prod.yaml
