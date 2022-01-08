from diagrams import Cluster, Diagram, Edge
from diagrams.generic.os import LinuxGeneral
from diagrams.k8s.ecosystem import Helm
from diagrams.k8s.infra import Node
from diagrams.onprem.container import Docker
from diagrams.onprem.gitops import ArgoCD
from diagrams.onprem.compute import Server
from diagrams.custom import Custom

graph_attr = {
    "pad": "0"
}

class Rocky(Custom):
    def __init__(self, label):
        super(Rocky, self).__init__(label, './img/fedora-logo-icon.png')

class K3s(Custom):
    def __init__(self, label):
        super(K3s, self).__init__(label, './img/k3s-icon-color.png')

class Cloudflare(Custom):
    def __init__(self, label):
        super(Cloudflare, self).__init__(label, './img/cloudflare_icon.png')

with Diagram("Provisioning flow", graph_attr=graph_attr, outformat="jpg", show=False):
    
    controller = Server("Controller")
            
    with Cluster("./metal") as metal:
        metals = Server("Metal cluster")
        pxe = Docker("PXE server")        
        rockies = Rocky('Rocky Linux')
        initial_resources = [
            metals,
            pxe
        ]
        k3s = K3s('K3s')

        rockies >> k3s
        metals >> rockies

    controller >> initial_resources

    with Cluster("./bootstrap") as bootstrap:
        nodes = Node('Node(s)')
        argocd = ArgoCD('ArgoCD')
        root_chart = Helm("Root chart")
    
    
    
    k3s >> nodes
    k3s >> argocd

    with Cluster('Kubernetes cluster'):
        with Cluster("./system"):
            system_chart = Helm("System chart")

        with Cluster("./platform"):
            platform_chart = Helm("Platform chart")

        with Cluster("./apps"):
            apps_chart = Helm("Applications chart")

        with Cluster("./global"):
            global_chart = Helm("Global chart")

            cloudflare = Cloudflare('Cloudflare')

    argocd >>  root_chart
    
    root_chart >> system_chart
    root_chart >> platform_chart
    root_chart >> apps_chart
    
    root_chart >> global_chart

    
    controller >> cloudflare

