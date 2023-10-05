#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  # Remove bloat
  sudo apt remove \
    thunderbird \
    simple-scan \
    gnome-mines \
    gnome-todo \
    gnome-sudoku \
    gnome-mahjongg \
    deja-dup \
    aisleriot

  # Update/upgrade/install
  sudo apt -y update && sudo apt -y upgrade && sudo apt install \
    gcc \
    g++ \
    tree \
    neofetch \
    jq \
    sxhkd \
    entr \
    direnv \
    htop \
    ripgrep \
    fd-find \
    curl \
    wget \
    git \
    tmux \
    vim \
    nano \
    make \
    cmake \
    rar \
    unrar \
    zip \
    xsel \
    wmctrl \
    stow \
    rofi \
    mysql-client \
    postgresql-client \
    trash-cli \
    net-tools \
    vim-gtk \
    uget \
    gparted \
    flameshot \
    gpick \
    screenkey \
    simplescreenrecorder \
    timeshift \
    vlc \
    gimp \
    peek \
    gnome-sushi \
    gnome-shell-extensions\
    gnome-clocks \
    gnome-tweaks \
    chrome-gnome-shell
fi

echo ""
echo "Install PPA app"
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt -y install obs-studio ibus-bamboo

echo ""
echo "Increasing the amount of inotify watchers"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
