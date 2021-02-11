ping:
	@echo "Pinging the hosts ..." 
	@cd scripts/ansible && ansible all -m ping

init:
	@cd infras && terraform init

plan:
	@cd infras && terraform plan

apply:
	@cd infras && terraform apply -auto-approve

destroy:
	@cd infras && terraform destroy
	
cleanup:
	@cd ../scripts/ansible/ && ansible-playbook clean_up.yaml -K