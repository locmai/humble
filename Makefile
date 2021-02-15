ping:
	@echo "Pinging the hosts ..." 
	@cd scripts/ansible && ansible all -m ping

init:
	@cd infras && terraform init

plan:
	@cd infras && terraform plan

fmt: 
	@cd infras && terraform fmt

apply:
	@cd infras && terraform apply

destroy:
	@cd infras && terraform destroy

clean:
	@rm -rf infras/terraform.tfstate.** infras/dev.log infras/rke_debug.log

cleanup-nodes:
	@cd scripts/ansible/ && ansible-playbook clean_up.yaml -K

start-ddns:
	@cd scripts/ansible/ && ansible-playbook start_ddns.yaml -K

.PHONY: platform
platform:
	make -C platform

.PHONY: infras
infras:
	make -C infras

.PHONY: apps
apps:
	make -C apps
