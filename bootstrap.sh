#!/bin/sh

PROJECTS=$HOME/projects
GIT_USER=karlwalsh
GIT_REPO=env
URL=https://github.com/$GIT_USER/$GIT_REPO.git

echo "Bootstrapping local machine - first updating, and installing dependencies"

sudo apt update
sudo apt install -y git make


mkdir -p $PROJECTS
cd $PROJECTS || exit
if [ ! -d "$GIT_REPO" ] ; then
  echo "$PROJECTS/$GIT_REPO doesn't exist, will clone from $URL"
  git clone $URL $GIT_REPO
else
  echo "$GIT_REPO project already exists, no need to clone"
fi

cd $GIT_REPO || exit


make bootstrap


sudo apt update
sudo apt -y full-upgrade
sudo apt -y autoremove

echo "Done - you will need to logout/restart for some changes to take effect"