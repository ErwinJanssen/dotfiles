TAGS ?= all

.PHONY: playbook
playbook:
	ansible-playbook -i hosts site.yml --tags "${TAGS}"
