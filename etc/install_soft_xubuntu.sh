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
  wmctrl \
  xtrlock \
  vlc \
  graphviz \
  clang-format \
  stow \
  thunar-archive-plugin \
  fonts-noto-color-emoji \
  xfce4-clipman-plugin \
  blueman \
  mugshot
fi
