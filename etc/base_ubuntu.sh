#!/usr/bin/env bash

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
  postgresql-client \
  mysql-client \
  clang-format \
  cppcheck \
  stow \
  rofi \
  fonts-noto-color-emoji \
  vlc \
  blender \
  gimp \
  gpick \
  inkscape \
  uget \
  flameshot \
  gparted \
  mpv \
  vim-gtk \
  simplescreenrecorder \
  vifm \
  timeshift \
  transmission
fi

echo ""
echo "Switch to zsh ..."
chsh -s $(which zsh)

DIR_FZF="$HOME/.fzf/"
if [ ! -d "$DIR_FZF" ]; then
  echo "Installing fzf ..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

DIR_ASDF="$HOME/.asdf/"
if [ ! -d "$DIR_ASDF" ]; then
  echo "Installing asdf ..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.2
fi
