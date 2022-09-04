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
  watchman \
  rar \
  unrar \
  zip \
  ibus \
  xsel \
  xclip \
  wmctrl \
  graphviz \
  vim-gtk \
  postgresql-client \
  mysql-client \
  clang-format \
  cppcheck \
  stow \

  vlc \
  blender \
  gimp \
  gpick \
  inkscape
fi
