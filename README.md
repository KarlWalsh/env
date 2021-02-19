# Instructions

## Install ansible (and dependencies)

    sudo apt install ansible
    ansible-galaxy collection install community.general


## Download playbook

    wget https://raw.githubusercontent.com/karlwalsh/env/master/ansible/development.yml


## Run playbook

    ansible development.yml -K

The default behaviour is to not configure git - if you wish to configure git then provide the following tag and variables

    ansible development.yml -K --tags configure-git -e "git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"
