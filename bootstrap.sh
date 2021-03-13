#!/bin/sh

ENV=$HOME/.env
URL=https://github.com/karlwalsh/env.git

echo "Bootstrapping local machine - first updating, and installing dependencies"

sudo apt update
sudo apt install -y git make

if [ ! -d "$ENV" ] ; then
  echo "$ENV doesn't exist, will clone from $URL"
  git clone --recurse-submodules $URL $ENV
else
  echo "$ENV project already exists, no need to clone"
fi

cd $ENV || exit

make bootstrap

echo "Done - you will need to logout/restart for some changes to take effect"