PROD_DOMAIN: str = 'maibaloc.com'
PROD_ZONE_ID: str = '54464d6437d5b02346a086b882bed154'

DEV_DOMAIN: str = 'locmai.dev'
DEV_ZONE_ID: str = '7ca29071dbe54a078c0fbf643d3c0923'

APPS = {
    'argocd': {
        'namespace': 'argocd',
        'service_name': 'argocd-server',
        'service_port': 80,
    },
    'gitea': {
        'namespace': 'platform',
        'service_name': 'gitea-http',
        'service_port': 3000,
    },
    'authentik': {
        'namespace': 'platform',
        'service_name': 'authentik',
        'service_port': 9100,
    },
    'grafana': {
        'namespace': 'observability',
        'service_name': 'monitoring-grafana',
        'service_port': 80,
    },
}
