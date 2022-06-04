# Simple demonstration of event-driven Argo Workflow

Components:
- Argo Workflow
- Argo Events (Event bus, event source and sensor)
- Alertmanager

## Apply the resources

```
kubectl apply -f sensor-rbac.yaml
kubectl apply -f workflow-rbac.yaml

kubectl apply -f eventbus.yaml
kubectl apply -f eventsource.yaml
kubectl apply -f sensor.yaml
```

## Test command

Simple curl:

```
kubectl -n argoworkflow port-forward $(kubectl -n argoworkflow get pod -l eventsource-name=webhook-demo -o name) 12000:12000

curl -d '{"message":"this is my first webhook"}' -H "Content-Type: application/json" -X POST http://localhost:12000/demo

curl -d '{"alerts": [{"labels":{"message": "hello"}}]}' -H "Content-Type: application/json" -X POST http://localhost:12000/demo
```

amtool test:

```
amtool alert add "Test Alert" ops=argo-events workflow=test-workflow \
        --annotation=runbook='http://runbook.biz' \
        --annotation=summary='summary of the alert' \
        --annotation=description='description of the alert'
```

The Alertmanager will send HTTP POST requests in the following JSON format to the configured endpoint:

```json
{
  "receiver": "argo-eventsource",
  "status": "firing",
  "alerts": [
    {
      "status": "firing",
      "labels": {
        "alertname": "Test Alert",
        "ops": "argo-events"
      },
      "annotations": {
        "description": "description of the alert",
        "runbook": "http://runbook.biz",
        "summary": "summary of the alert"
      },
      "startsAt": "2022-06-04T08:25:09.349094001Z",
      "endsAt": "0001-01-01T00:00:00Z",
      "generatorURL": "",
      "fingerprint": "966bc69b4b56f1c3"
    }
  ],
  "groupLabels": {
    "ops": "argo-events"
  },
  "commonLabels": {
    "alertname": "Test Alert",
    "ops": "argo-events"
  },
  "commonAnnotations": {
    "description": "description of the alert",
    "runbook": "http://runbook.biz",
    "summary": "summary of the alert"
  },
  "externalURL": "http://monitoring-kube-prometheus-alertmanager.observability:9093",
  "version": "4",
  "groupKey": "{}/{ops=\"argo-events\"}:{ops=\"argo-events\"}",
  "truncatedAlerts": 0
}
```

We could extract the information from `commonLabels`, `commonAnnotations`,`alerts.labels`, `alerts.annotations`, etc.

Data structure of the alerts: https://prometheus.io/docs/alerting/latest/notifications/#alert
