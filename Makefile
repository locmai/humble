.POSIX:
default: metal bootstrap

.PHONY: init
init:
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

.PHONY: metal
metal:
	make -C metal


.PHONY: bootstrap
bootstrap:
	make -C bootstrap

.PHONY: lint
lint:
	# TODO (feature) Add lint checks for everything
	# make -C metal lint
	echo 'Linting'

.PHONY: tools
tools:
	make -C tools