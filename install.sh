#!/usr/bin/env bash

./etc/debian_setup.sh
./etc/gnome_setup.sh
./etc/install_fzf.sh
./etc/install_nix.sh

stow .
