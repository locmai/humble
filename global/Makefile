env ?= prod

default:
	cd ${env} && terragrunt init -upgrade && terragrunt apply -auto-approve
