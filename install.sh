#!/usr/bin/env bash

./etc/ubuntu_setup.sh
./etc/gnome_setup.sh
./etc/install_nix.sh
./etc/install_fzf.sh

[ -f $(which fdfind) ] && sudo ln -sf $(which fdfind) ~/.local/bin/fd
stow .
