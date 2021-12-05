.POSIX:

env ?= "prod"

default:
	ansible-playbook \
		--inventory inventories/${env}.ini \
		boot.yml
