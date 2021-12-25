.POSIX:
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ../metal/kubeconfig.yaml

env ?= "prod"

default: argocd app

.PHONY: argocd
argocd:
	kustomize build ./argocd | kubectl apply -f -

.PHONY: app
app:
	kubectl apply -f ./app/root-${env}..yaml
