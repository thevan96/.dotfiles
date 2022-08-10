#!/bin/bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  sudo apt -y update && sudo apt -y upgrade && sudo apt install \
  gcc \
  g++ \
  tree \
  neofetch \
  htop \
  ripgrep \
  fd-find \
  curl \
  wget \
  zsh \
  git \
  tmux \
  vim \
  nano \
  make \
  cmake \
  ccls \
  transmission \
  uget \
  blender \
  gimp \
  inkscape \
  flameshot \
  watchman \
  gparted \
  mpv \
  rar \
  unrar \
  zip \
  ibus \
  xsel \
  xclip \
  gnome-tweaks \
  gnome-screensaver \
  wmctrl \
  xtrlock \
  vlc \
  chrome-gnome-shell \
  graphviz \
  vim-gtk \
  clang-format \
  stow
fi
