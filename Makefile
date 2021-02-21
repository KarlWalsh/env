.PHONY: help

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


help: ## This help page
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'


install: ## Install and configure development environment software
	@ansible-galaxy collection install -r ansible/requirements.yml
	@ansible-playbook -v ansible/development.yml --ask-become-pass


configure-git: ## Configure global .gitconfig and .gitignore - Provide arguments GIT_USERNAME="some name" and GIT_EMAIL=you@mail.com
	$(call check_defined, GIT_USERNAME)
	$(call check_defined, GIT_EMAIL)

	@ansible-playbook -v ansible/development.yml --tags configure-git -e "git_username='$(GIT_USERNAME)' git_email=$(GIT_EMAIL)"


configure-swap: ## Update an existing /swapfile with size in gigabytes provided by the argument SWAP_SIZE=2
	$(call check_defined, SWAP_SIZE)

	@ansible-playbook -v ansible/development.yml --ask-become-pass --tags configure-swap -e "swap_space_gig=$(SWAP_SIZE)"


.DEFAULT_GOAL := help
