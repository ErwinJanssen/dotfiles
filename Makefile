TAGS ?= all

.PHONY: configure
configure: guix playbook

.PHONY: guix
guix:
	guix home reconfigure guix/home-configuration.scm

.PHONY: playbook
playbook:
	ansible-playbook --diff -i hosts site.yml --tags "${TAGS}"

.PHONY: shell
shell:
	guix shell --manifest=manifest.scm
