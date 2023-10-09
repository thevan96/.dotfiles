#!/usr/bin/env bash

sudo nixos-rebuild switch -I nixos-config=$HOME/.dotfiles/configuration.nix
