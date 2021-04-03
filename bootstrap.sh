#!/bin/env sh

ENV="$HOME/.env"
URL="git@github.com:karlwalsh/env.git"

printf "Bootstrapping local machine - first updating, and installing dependencies\n"

sudo apt update
sudo apt install -y git make

if [ ! -d "$ENV" ] ; then
  printf ''\''%s'\'' doesn'\''t exist, will clone from '\''%s'\''\n' "$ENV" "$URL"
  git clone --recurse-submodules "$URL" "$ENV"
else
  printf ''\''%s'\'' project already exists, no need to clone\n' "$ENV"
fi

cd "$ENV" || exit

make bootstrap

printf "Done - you will need to logout/restart for some changes to take effect\n"