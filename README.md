# Instructions

## Install ansible (and dependencies)

    sudo apt install ansible
    ansible-galaxy collection install community.general


## Download playbook

    wget https://raw.githubusercontent.com/karlwalsh/env/master/ansible/development.yml


## Run playbook

    ansible development.yml -K

The default behaviour is to not configure git - if you wish to configure git then provide the following extra vars

    ansible development.yml -K -e "configure_git=true git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"
