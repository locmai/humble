ping:
	@echo "Pinging the hosts ..." 
	@cd metal/ansible && ansible all -m ping

clean:
	@rm -rf infras/terraform/terraform.tfstate.** infras/terraform/dev.log infras/terraform/rke_debug.log

cleanup-nodes:
	@cd scripts/ansible/ && ansible-playbook clean_up.yaml -K

shutdown:
	@cd scripts/ansible/ && ansible-playbook shut_down_all.yaml -K

wake:
	@cd scripts/ansible/ && ansible-playbook wake.yaml

all: metal infras platform apps

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
