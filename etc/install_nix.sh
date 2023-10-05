#!/usr/bin/env bash

if [ ! -d "/nix" ]; then
  curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
  nix-channel --add https://nixos.org/channels/nixos-23.05 nixpkgs
  nix-channel --add https://nixos.org/channels/nixpkgs-unstable unstable
  nix-channel --update

  nix-env -iA nixpkgs.nodejs_18 nixpkgs.neovim

  nix-env -iA unstable.lua-language-server \
    unstable.gopls \
    unstable.rust-analyzer \
    unstable.marksman \
    unstable.nixd \

  npm i -g vscode-langservers-extracted \
    cssmodules-language-server \
    typescript-language-server \
    prettier
fi
