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
  clang-tools \
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
  nnn \
  ranger \
  watchman \
  gparted \
  mpv \
  rar \
  unrar \
  zip \
  gnome-shell-pomodoro \
  ibus \
  clangd-12 \
  xsel \
  xclip \
  gnome-tweaks \
  gnome-screensaver \
  wmctrl \
  xtrlock \
  vlc \
  peek \
  obs-studio \
  ibus-bamboo \
  chrome-gnome-shell \
  vim-gtk \

  sudo update-alternatives --install /usr/bin/clangd clangd /usr/bin/clangd-12 100
fi
