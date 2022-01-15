.POSIX:

env ?= "prod"

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
