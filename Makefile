TAGS ?= all

.PHONY: playbook
playbook:
	ansible-playbook --diff -i hosts site.yml --tags "${TAGS}"
