TAGS ?= all

.PHONY: configure
configure: guix playbook

.PHONY: guix
guix:
	guix home reconfigure guix/home-configuration.scm

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
