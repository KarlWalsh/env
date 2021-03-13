# Instructions

## Download and execute for a fresh install

    wget -qO- https://raw.githubusercontent.com/karlwalsh/env/master/bootstrap.sh | sh

This script does the following
1. Install dependencies (git and ansible)
2. Checks out the git project under `~/projects/env` (skips if already checked out)
3. Moves into the project directory
4. Installs ansible requirements through `ansible-galaxy`
5. executes the ansible playbook

You will be asked for your password when it performs a `sudo apt update` and once again when ansible asks for the become password.

## Configure git

Update global git config - this will replace the existing global `~/.gitconfig` and `~/.gitignore` files.

    cd ~/projects/env
    make configure-git GIT_USERNAME="Groovy Gorilla" GIT_EMAIL=groovy.gorilla@ubuntu.com

## Configure swap

Update an existing swapfile at `/swapfile`. The variable `SWAP_SIZE` is in gigabytes. 

    cd ~/projects/env
    make configure-swap SWAP_SIZE=2

## TODO

- Use notifiers to handle service restarts
- Enable wayland
- zsh & oh-my-zsh for root
- Install virtualbox
- Better handling of dotfiles
    - chezmoi - https://github.com/twpayne/chezmoi
    - dotdrop - https://github.com/deadc0de6/dotdrop
    - dotbare - https://github.com/kazhala/dotbare
    - Use ansible to handle symlinks? - should make it easier to manage
      Use a variable for the src and dest root path
      ```
      - name: Symlink .tmux.conf
        file:
        src: "~/projects/env/ansible/roles/tmux/files/tmux.conf"
        dest: "~/.tmux.conf"
        state: link
      ```
    - Take inspiration from
        - https://github.com/Addvilz/dots
        - https://github.com/driesvints/dotfiles
        - https://github.com/sloria/dotfiles
- Desktop wallpapers