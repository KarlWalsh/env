# Instructions

## Install ansible (and dependencies)

    sudo apt install ansible
    ansible-galaxy collection install community.general


## Download playbook

    wget https://raw.githubusercontent.com/karlwalsh/env/master/ansible/development.yml


## Run playbook

    ansible-playbook development.yml -K

### Configuring git

Update global git config and pull down a global .gitignore template using the tag `configure-git`

    ansible-playbook development.yml --tags configure-git -e "git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"

### Configuring swap

Create or updates an existing swapfile at `/swapfile` using the tag `configure-swap`

    ansible-playbook development.yml -K --tags configure-swap -e "swap_space_gig=2"