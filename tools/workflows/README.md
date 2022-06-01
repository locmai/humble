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
TBD
```

The Alertmanager will send HTTP POST requests in the following JSON format to the configured endpoint:

```json
{
  "version": "4",
  "groupKey": <string>,              // key identifying the group of alerts (e.g. to deduplicate)
  "truncatedAlerts": <int>,          // how many alerts have been truncated due to "max_alerts"
  "status": "<resolved|firing>",
  "receiver": <string>,
  "groupLabels": <object>,
  "commonLabels": <object>,
  "commonAnnotations": <object>,
  "externalURL": <string>,           // backlink to the Alertmanager.
  "alerts": [
    {
      "status": "<resolved|firing>",
      "labels": <object>,
      "annotations": <object>,
      "startsAt": "<rfc3339>",
      "endsAt": "<rfc3339>",
      "generatorURL": <string>,      // identifies the entity that caused the alert
      "fingerprint": <string>        // fingerprint to identify the alert
    },
    ...
  ]
}
```

We could extract the information from `commonLabels`, `commonAnnotations`,`alerts.labels`, `alerts.annotations`, etc.

Data structure of the alerts: https://prometheus.io/docs/alerting/latest/notifications/#alert
