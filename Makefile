.POSIX:
.PHONY: *

default:
	make -C metal env=prod
	make -C bootstrap env=prod
	make -C global env=prod

init:
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

tools:
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
		docker.io/nixos/nix nix --experimental-features 'nix-command flakes' develop

dev:
	make -C metal k3d env=dev
	make -C bootstrap env=dev

stag:
	make -C metal env=stag
	make -C bootstrap env=stag
	make -C global env=stag

docs:
	docker run \
		--rm \
		--interactive \
		--tty \
		--publish 8000:8000 \
		--volume $(shell pwd):/docs \
		squidfunk/mkdocs-material

