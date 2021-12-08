import pulumi
from pulumi_kubernetes.networking.v1 import Ingress
from pulumi_kubernetes import Provider

from constants import PROD_DOMAIN, PROD_ZONE_ID, APPS


def create_kubernetes_resources():
    ingress_records = []

    with open("../metal/kubeconfig.yaml") as f:
        kubeconfig = f.read()

    k8s_provider = Provider(
        resource_name='kubernetes-provider',
        kubeconfig=kubeconfig
    )

    for app, metadata in APPS.items():
        ingress_records.append(
            Ingress(
                f"{app}-ingress'",
                metadata={
                    'name': f"{app}-ingress",
                    'namespace': metadata["namespace"]
                },
                spec={
                    "rules": [
                        {
                            "host": f"{app}.{PROD_DOMAIN}",
                            "http": {
                                "paths": [
                                    {
                                        "pathType": "Prefix",
                                        "path": "/",
                                        "backend": {
                                            "service": {
                                                "name": metadata["service_name"],
                                                "port": {
                                                    "number": metadata["service_port"]
                                                }
                                            }
                                        }

                                    },
                                ]
                            }
                        },
                    ]
                }
            )
        )
