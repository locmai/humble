from base64 import b64encode

import pulumi_cloudflare as cloudflare
from pulumi import ResourceOptions, Config

from constants import PROD_DOMAIN, PROD_ZONE_ID, PROD_ACCOUNT_ID, APPS


def create_cloudflare_resources():
    root_record = cloudflare.Record(
        "root-record",
        name=f"root.{PROD_DOMAIN}",
        zone_id=PROD_ZONE_ID,
        type="A",
        value="12.34.56.78",
        proxied=True,
        ttl=1,
        opts=ResourceOptions(
            ignore_changes=["value"])
    )

    ingress_records = []

    for app in APPS:
        ingress_records.append(
            cloudflare.Record(
                f"{app}-record",
                name=app,
                zone_id=PROD_ZONE_ID,
                type='CNAME',
                value=f"root.{PROD_DOMAIN}",
                proxied=True,
                ttl=1,
                opts=ResourceOptions(depends_on=[root_record])
            )
        )

    config = Config()
    argo_tunnel_secret = str(b64encode(bytes(config.get('argo_tunnel_secret'), 'utf-8')))
    root_argo_tunnel = cloudflare.ArgoTunnel(
        name='prod-tunnel',
        account_id=PROD_ACCOUNT_ID,
        resource_name='prod-tunnel',
        secret=argo_tunnel_secret
    )
