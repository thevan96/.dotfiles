#!/usr/bin/env bash

if [ ! -d "/nix" ]; then
  sh <(curl -L https://nixos.org/nix/install) --no-daemon
  nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
  if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
    . "$HOME/.nix-profile/etc/profile.d/nix.sh"
  fi
  nix-channel --update

  nix-env -iA nixpkgs.nodejs_20  \
    nixpkgs.neovim \
    nixpkgs.direnv \
    nixpkgs.nix-direnv \
    nixpkgs.fd \
    nixpkgs.ripgrep \
    nixpkgs.shellcheck \
    nixpkgs.wmctrl \
    nixpkgs.neofetch \
    nixpkgs.trash-cli \
    nixpkgs.nettools \
    nixpkgs.jq \
    nixpkgs.entr \
    nixpkgs.htop

  nix-env -iA nixpkgs.lua-language-server \
    nixpkgs.gopls \
    nixpkgs.rust-analyzer \
    nixpkgs.nixd \
    nixpkgs.marksman \
    nixpkgs.docker \
    nixpkgs.docker-compose

  npm i -g vscode-langservers-extracted \
    cssmodules-language-server \
    typescript-language-server \
    typescript \
    bash-language-server \
    browser-sync \
    prettier
fi
