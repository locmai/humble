#!/bin/sh

helm template \
    --include-crds \
    --namespace argocd \
    bootstrap-argocd . -f values-$1.yaml \
    | kubectl apply -n argocd -f -

kubectl -n argocd wait --timeout=60s --for condition=Established \
       crd/applications.argoproj.io

