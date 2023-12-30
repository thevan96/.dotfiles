#!/usr/bin/env bash
set -e

stow .
./etc/fedora_setup.sh
./etc/install_nix.sh
