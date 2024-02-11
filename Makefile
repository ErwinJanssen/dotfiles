TAGS ?= all

TEMPLATES_CHECKSUM := templates.checksum
CURRENT_CHECKSUM := $(shell find guix/ -type f -path '*/templates/*' | sha256sum)

.PHONY: configure
configure: guix playbook

.PHONY: clean
clean:
	git clean -xdf

.PHONY: guix
guix: process-templates | checksum-templates
	guix home reconfigure guix/home-configuration.scm

.PHONY: process-templates
process-templates: process-templates.mk

process-templates.mk: templates.checksum
	python3 scripts/generate_process_templates_makefile.py > process-templates.mk

include process-templates.mk

.PHONY: playbook
playbook: theme.json
	ansible-playbook --diff -i hosts site.yml --tags "${TAGS}"

# Generate JSON file from Scheme data file. Pipe through `jq` to verify that
# the output is valid JSON.
%.json: guix/%.scm
	guile -c '(use-modules (json)) (define data (load "$<")) (scm->json data)' | jq > "$@"

.PHONY: shell
shell:
	guix shell --manifest=manifest.scm

.PHONY: container
container:
	guix home container guix/home-configuration.scm

# Generate Guix service data files from templates
.PHONY: checksum-templates
$(TEMPLATES_CHECKSUM) checksum-templates:
	@if [ -f $(TEMPLATES_CHECKSUM) ]; then \
		if [ "$(CURRENT_CHECKSUM)" != "$$(cat $(TEMPLATES_CHECKSUM))" ]; then \
			echo "$(CURRENT_CHECKSUM)" > $(TEMPLATES_CHECKSUM); \
			echo "Checksum has changed. Updating $(TEMPLATES_CHECKSUM)."; \
		else \
			echo "Checksum has not changed. $(TEMPLATES_CHECKSUM) is up-to-date."; \
		fi \
	else \
		echo "$(CURRENT_CHECKSUM)" > $(TEMPLATES_CHECKSUM); \
		echo "Checksum file $(TEMPLATES_CHECKSUM) created with initial value."; \
	fi
