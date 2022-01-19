from diagrams import Cluster, Diagram, Edge
from diagrams.custom import Custom
from diagrams.k8s.podconfig import Secret
from diagrams.programming.language import Python
from diagrams.k8s.rbac import ServiceAccount
from diagrams.onprem.gitops import ArgoCD

graph_attr = {
    "pad": "0"
}

class Vault(Custom):
    def __init__(self, label):
        super(Vault, self).__init__(label, './img/vault.png')

class ExternalSecrets(Custom):
    def __init__(self, label):
        super(ExternalSecrets, self).__init__(label, './img/external-secrets.png')

with Diagram("Secret Management Flow", graph_attr=graph_attr, outformat="jpg", show=False):
    init_script = Python("vault_init.py")
    
    init_secrets = Secret('Kubernetes secrets')
    



    with Cluster("External-secrets components") as external_secrets_cluster:
        external_service_account = ServiceAccount('Service account')
        external_secrets = ExternalSecrets("Secret workers")
        external_secrets_manifests = Secret('External secrets')

        external_secrets << external_secrets_manifests

        external_secrets << external_service_account

    with Cluster("Vault components") as vault_cluster:
        vault = Vault('vault')
        vault_init_secrets = Secret('vault-init-secrets')

    init_script >> vault >> external_secrets >> init_secrets

