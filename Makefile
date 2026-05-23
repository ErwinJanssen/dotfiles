TAGS ?= all

.PHONY: nix
nix:
	nix run home-manager -- switch --flake .

.PHONY: clean
clean:
	git clean -xdf

# Generate JSON file from Python script.
%.json: scripts/%.py
	python3 "$<" > "$@"
