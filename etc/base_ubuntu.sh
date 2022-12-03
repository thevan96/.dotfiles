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
  screenkey \
  simplescreenrecorder \
  vifm \
  timeshift \
  tig \
  sxhkd \
  transmission
fi

echo ""
echo "Switch to zsh ..."
chsh -s $(which zsh)

dir_fzf="$HOME/.fzf/"
if [ ! -d "$dir_fzf" ]; then
  echo "Installing fzf ..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

dir_asdf="$HOME/.asdf/"
if [ ! -d "$dir_asdf" ]; then
  echo "Installing asdf ..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi

dir_vimplug="$HOME/.local/share/nvim/"
if [ ! -d "$dir_vimplug" ]; then
  echo "Installing vimplug ..."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi
