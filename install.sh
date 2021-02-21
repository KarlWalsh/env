#!/bin/sh

sudo apt-get update
sudo apt install -y git ansible

PROJECTS=projects
GIT_USER=karlwalsh
GIT_REPO=env
URL=https://github.com/$GIT_USER/$GIT_REPO.git

cd ~ || exit
mkdir -p $PROJECTS
cd $PROJECTS || exit
if [ ! -d "$GIT_REPO" ] ; then
  git clone $URL $GIT_REPO
else
  echo "$GIT_REPO project already exists, no need to clone"
fi

cd $GIT_REPO || exit

ansible-galaxy collection install -r ansible/requirements.yml
ansible-playbook -v ansible/development.yml --ask-become-pass

sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove