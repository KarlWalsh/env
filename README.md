# Instructions

## Install ansible (and dependencies)

    sudo apt install ansible
    ansible-galaxy collection install community.general


## Download playbook

    wget https://raw.githubusercontent.com/karlwalsh/env/master/ansible/development.yml


## Run playbook

    ansible development.yml -K
