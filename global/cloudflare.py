import pulumi_cloudflare as cloudflare
from pulumi import ResourceOptions

from constants import PROD_DOMAIN, PROD_ZONE_ID, APPS

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
