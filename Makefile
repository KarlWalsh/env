# Got this from https://stackoverflow.com/questions/10858261/how-to-abort-makefile-if-variable-not-set#answer-10858332
#
# Check that given variables are set and all have non-empty values,
# die with an error otherwise.
#
# Params:
#   1. Variable name(s) to test.
#   2. (optional) Error message to print.
check_defined = \
    $(strip $(foreach 1,$1, \
        $(call __check_defined,$1,$(strip $(value 2)))))
__check_defined = \
    $(if $(value $1),, \
      $(error Undefined $1$(if $2, ($2))))

ANSIBLE_GALAXY = ansible-galaxy collection install -r ansible/requirements/collections.yml
ANSIBLE_PLAYBOOK = ansible-playbook ansible/local-machine.yml -v --ask-become-pass

.PHONY: help
help: ## This help page
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


.PHONY: bootstrap
bootstrap: ##Install dependencies and then install everything
	sudo apt update
	sudo apt install -y ansible software-properties-common python3-psutil
	make ansible-requirements
	make install
	sudo apt update
	sudo apt -y full-upgrade
	sudo apt -y autoremove


.PHONY: ansible-requirements
ansible-requirements: ##Install ansible requirements
	$(ANSIBLE_GALAXY)


.PHONY: install
install: ## Install everything, and configure all but git and swap
	$(ANSIBLE_PLAYBOOK)


.PHONY: tools
tools: ## Install and configure apps and tools
	$(ANSIBLE_PLAYBOOK) --tags tools


.PHONY: development
development: ## Install and configure development apps and tools
	$(ANSIBLE_PLAYBOOK) --tags development


.PHONY: jdk
jdk: ## Install and configure jdks
	$(ANSIBLE_PLAYBOOK) --tags jdk


.PHONY: docker
docker: ## Install and configure docker
	$(ANSIBLE_PLAYBOOK) --tags docker


.PHONY: k8s
k8s: ## Install and configure kubernetes
	$(ANSIBLE_PLAYBOOK) --tags k8s


.PHONY: fonts
fonts: ## Install fonts
	$(ANSIBLE_PLAYBOOK) --tags fonts


.PHONY: terminal
terminal: ## Install and configure terminal
	$(ANSIBLE_PLAYBOOK) --tags terminal


.PHONY: alacritty
alacritty: ## Install and configure alacritty
	$(ANSIBLE_PLAYBOOK) --tags alacritty


.PHONY: kubernetes
kubernetes: ## Install and configure kubernetes tools
	$(ANSIBLE_PLAYBOOK) --tags kubernetes


.PHONY: 1password
1password: ## Install and configure 1Password
	$(ANSIBLE_PLAYBOOK) --tags 1password


.PHONY: rofi
rofi: ## Install and configure rofi
	$(ANSIBLE_PLAYBOOK) --tags rofi


.PHONY: gnome
gnome: ## Configure gnome
	$(ANSIBLE_PLAYBOOK) --tags gnome


.PHONY: configure-git
configure-git: ## Configure global .gitconfig and .gitignore - Provide arguments GIT_USERNAME="some name" and GIT_EMAIL=you@mail.com
	$(call check_defined, GIT_USERNAME)
	$(call check_defined, GIT_EMAIL)

	$(ANSIBLE_PLAYBOOK) --tags configure-git -e "git_username='$(GIT_USERNAME)' git_email=$(GIT_EMAIL)"


.PHONY: configure-swap
configure-swap: ## Update an existing /swapfile with size in gigabytes provided by the argument SWAP_SIZE=2
	$(call check_defined, SWAP_SIZE)

	$(ANSIBLE_PLAYBOOK) --tags configure-swap -e "swap_space_gig=$(SWAP_SIZE)"


.DEFAULT_GOAL := help
