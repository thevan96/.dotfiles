#!/usr/bin/env bash
set -e

if [ ! -d "/nix" ]; then
  sh <(curl -L https://nixos.org/nix/install) --no-daemon

  source ~/.bashrc
  nix-channel --add https://nixos.org/channels/nixos-23.11 nixpkgs
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
  nix-channel --update

  nix-env -iA nixpkgs.nix-direnv

  # nix-env -iA \
  #   nixpkgs.gopls \
  #   nixpkgs.lua-language-server \
  #   nixpkgs.marksman \
  #   nixpkgs.nixd \
  #   nixpkgs.rust-analyzer

  # npm i -g vscode-langservers-extracted \
  #   bash-language-server \
  #   browser-sync \
  #   cssmodules-language-server \
  #   prettier \
  #   typescript \
  #   typescript-language-server
fi
