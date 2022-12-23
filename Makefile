.POSIX:
.PHONY: *

default:
	make -C metal env=prod
	make -C bootstrap env=prod
	make -C global env=prod

init:
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

tools:
	@echo making tools shell, going to take a while...
	@docker run \
		--rm \
		--interactive \
		--tty \
		--network host \
		--env "KUBECONFIG=${KUBECONFIG}" \
		--volume "/var/run/docker.sock:/var/run/docker.sock" \
		--volume $(shell pwd):$(shell pwd) \
		--volume ${HOME}/.ssh:/root/.ssh \
		--volume ${HOME}/.terraform.d:/root/.terraform.d \
		--volume homelab-tools-cache:/root/.cache \
		--volume homelab-tools-nix:/nix \
		--workdir $(shell pwd) \
		nixos/nix nix-shell

dev:
	make -C metal k3d env=dev
	make -C bootstrap env=dev

stag:
	make -C metal env=stag
	make -C bootstrap env=stag
	make -C global env=stag

docs:
	mkdocs serve

