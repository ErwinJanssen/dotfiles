TAGS ?= all

_:=$(shell bash scripts/checksum_templates.sh)

.PHONY: configure
configure: nix guix playbook

.PHONY: clean
clean:
	git clean -xdf

.PHONY: nix
nix: theme.json
	home-manager --file nix/home-manager/home.nix switch

.PHONY: guix
guix: process-templates
	guix home reconfigure guix/home-configuration.scm

.PHONY: process-templates
process-templates: process-templates.mk

process-templates.mk: templates.checksum
	python3 scripts/generate_process_templates_makefile.py > process-templates.mk

templates.checksum:

.PHONY: playbook
playbook: theme.json
	ansible-playbook --diff -i hosts site.yml --tags "${TAGS}"

# Generate JSON file from Python script.
%.json: scripts/%.py
	python3 "$<" > "$@"

.PHONY: shell
shell:
	guix shell --manifest=manifest.scm

.PHONY: container
container:
	guix home container guix/home-configuration.scm
