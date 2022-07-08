.POSIX:
.PHONY: *

default:
	make -C metal env=prod
	make -C bootstrap env=prod
	make -C global env=prod

init:
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

tools:
	make -C tools

dev:
	make -C metal k3d env=dev
	make -C bootstrap env=dev

stag:
	make -C metal env=stag
	make -C bootstrap env=stag
	make -C global env=stag
