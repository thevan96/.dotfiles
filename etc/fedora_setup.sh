#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  # Update/upgrade/install
  sudo dnf -y update && sudo dnf -y upgrade && sudo dnf -y install \
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
    rar \
    unrar \
    zip \
    ibus \
    xsel \
    xclip \
    wmctrl \
    postgresql-client \
    mysql-client \
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
    vim-gtk \
    screenkey \
    simplescreenrecorder \
    timeshift \
    rofi \
    transmission \
    gnome-shell-extensions\
    gnome-clocks \
    gnome-tweaks \
    chrome-gnome-shell \
    gnome-shell-pomodoro
fi

# Change shell
echo ""
echo "Switch to zsh ..."
chsh -s $(which zsh)

# Make alias
if [ ! -f "fdfind" ]; then
  sudo ln -sf $(which fdfind) /usr/local/bin/fd
fi

if [ ! -f "nvim" ]; then
  sudo ln -sf $(which nvim) /usr/local/bin/vi
fi

# Install fzf
dir_fzf="$HOME/.fzf/"
if [ ! -d "$dir_fzf" ]; then
  echo "Installing fzf ..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi

# Install asdf
dir_asdf="$HOME/.asdf/"
if [ ! -d "$dir_asdf" ]; then
  echo "Installing asdf ..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
fi

# Install vimplug
dir_vimplug="$HOME/.local/share/nvim/"
if [ ! -d "$dir_vimplug" ]; then
  echo "Installing vimplug ..."
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Gnome setup
gsettings reset org.gnome.mutter overlay-key
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter dynamic-workspaces false
