# Instructions

## Install ansible (and dependencies)

    sudo apt install ansible
    ansible-galaxy collection install community.general


## Download playbook

    wget https://raw.githubusercontent.com/karlwalsh/env/master/ansible/development.yml


## Run playbook

### First run after a fresh install

    ansible-playbook development.yml -K
    ansible-playbook development.yml -K --tags configure-git -e "git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"
    ansible-playbook development.yml -K --tags configure-swap -e "swap_space_gig=2"

### Configuring git

Update global git config using the tag `configure-git` - this will also replace the existing global `~/.gitignore` file.

    ansible-playbook development.yml --tags configure-git -e "git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"

### Configuring swap

Update an existing swapfile at `/swapfile` using the tag `configure-swap`.

    ansible-playbook development.yml -K --tags configure-swap -e "swap_space_gig=2"