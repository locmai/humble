.POSIX:
default: metal bootstrap global

.PHONY: init
init:
	ssh-keygen -t ed25519 -f ~/.ssh/id_ed25519 -q -P ""

.PHONY: metal
metal:
	make -C metal


.PHONY: bootstrap
bootstrap:
	make -C bootstrap

.PHONY: tools
tools:
	make -C tools

.PHONY: global
global:
	make -C global
