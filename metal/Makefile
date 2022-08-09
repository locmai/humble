.POSIX:

env ?= prod

default: boot cluster

boot:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		boot.yml

cluster:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		cluster.yml

shutdown:
	ansible-playbook \
		--inventory inventories/${env}.yml \
		shutdown.yml

k3d:
	command -v k3d
	k3d cluster create --config k3d-dev.yaml
	k3d kubeconfig get humble-dev > kubeconfig.dev.yaml

console:
	ansible-console \
		--inventory inventories/${env}.yml
