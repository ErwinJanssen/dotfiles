TAGS ?= all

.PHONY: configure
configure: playbook nix

.PHONY: clean
clean:
	git clean -xdf

.PHONY: nix
nix:
	nix run home-manager -- switch --flake .

.PHONY: playbook
playbook: theme.json
	ansible-playbook --diff -i hosts site.yml --tags "${TAGS}"

# Generate JSON file from Python script.
%.json: scripts/%.py
	python3 "$<" > "$@"

.PHONY: shell
shell:
	nix-shell
