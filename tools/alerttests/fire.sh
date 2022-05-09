kubectl port-forward -n observability svc/monitoring-kube-prometheus-alertmanager 46833:9093

amtool alert list

amtool alert add "Test Alert" ops=yuta \
        --annotation=runbook='http://runbook.biz' \
        --annotation=summary='summary of the alert' \
        --annotation=description='description of the alert'
