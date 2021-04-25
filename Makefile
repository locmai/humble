ping:
	@cd metal/ansible && ansible all -m ping

clean:
	@cd scripts/ansible/ && ansible-playbook clean_up.yaml -K

shutdown:
	@cd scripts/ansible/ && ansible-playbook shut_down_all.yaml -K

wake:
	@cd scripts/ansible/ && ansible-playbook wake_all.yaml

all: metal infras platform apps todo

.PHONY: metal
metal:
	make -C metal

.PHONY: infras
infras:
	make -C infras

.PHONY: platform
platform:
	make -C platform

.PHONY: apps
apps:
	make -C apps

.PHONY: todo
todo:
	make -C docs
