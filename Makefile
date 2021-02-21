ping:
	@echo "Pinging the hosts ..." 
	@cd metal/ansible && ansible all -m ping

init:
	tfenv use 0.14.5
	@cd infras/terraform && terraform init

plan:
	tfenv use 0.14.5
	@cd infras/terraform && terraform plan

fmt:
	tfenv use 0.14.5
	@cd infras/terraform && terraform fmt

apply:
	tfenv use 0.14.5
	touch ./infras/kube_config.yml
	@cd infras/terraform && terraform apply

destroy:
	tfenv use 0.14.5
	@cd infras/terraform && terraform destroy

clean:
	@rm -rf infras/terraform/terraform.tfstate.** infras/terraform/dev.log infras/terraform/rke_debug.log

cleanup-nodes:
	@cd metal/ansible/ && ansible-playbook clean_up.yaml -K

start-ddns:
	@cd infras/ansible/ && ansible-playbook start_ddns.yaml -K

shutdown:
	@cd metal/ansible/ && ansible-playbook shutdown.yaml -K

.PHONY: infras
infras:
	make -C infras

.PHONY: platform
platform:
	make -C platform

.PHONY: apps
apps:
	make -C apps
