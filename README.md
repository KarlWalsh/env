# Instructions

## Download and execute for a fresh install

    wget -qO- https://raw.githubusercontent.com/karlwalsh/env/master/install.sh | sh

This script does the following
1. Install dependencies (git and ansible)
2. Checks out the git project under `~/projects/env` (skips if already checked out)
3. Moves into the project directory
4. Installs ansible requirements through `ansible-galaxy`
5. executes the ansible playbook

You will be asked for your password when it performs a `sudo apt update` and once again when ansible asks for the become password.

### Configuring git

Update global git config using the tag `configure-git` - this will also replace the existing global `~/.gitignore` file.

    ansible-playbook ansible/development.yml --tags configure-git -e "git_username='Groovy Gorilla' git_email=groovy.gorilla@ubuntu.com"

### Configuring swap

Update an existing swapfile at `/swapfile` using the tag `configure-swap`.

    ansible-playbook ansible/development.yml -K --tags configure-swap -e "swap_space_gig=2"