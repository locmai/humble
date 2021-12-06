.POSIX:
.EXPORT_ALL_VARIABLES:

KUBECONFIG = ../metal/kubeconfig.yaml

default: argocd app

.PHONY: argocd
argocd:
	kustomize build ./argocd | kubectl apply -f -

.PHONY: app
app:
	kubectl apply -f ./app/root.yaml
