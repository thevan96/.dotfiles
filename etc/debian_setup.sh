#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Remove game bloat
  sudo apt remove iagno \
    lightsoff \
    four-in-a-row \
    gnome-robots \
    pegsolitaire \
    gnome-2048 \
    hitori \
    gnome-klotski \
    gnome-mines \
    gnome-mahjongg \
    gnome-sudoku \
    quadrapassel \
    swell-foop \
    gnome-tetravex \
    gnome-taquin \
    aisleriot \
    gnome-chess \
    five-or-more \
    gnome-nibbles \
    tali \
    gnome-weather \
    synaptic \
    evolution

  sudo apt -y update && sudo apt -y upgrade && sudo apt install -y \
    python3-launchpadlib \
    git \
    curl \
    wget \
    vim \
    xsel \
    nano \
    make \
    tree \
    tmux \
    rar \
    unrar \
    zip \
    rofi \
    stow \
    postgresql-client

  sudo apt install -y \
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
    obs-studio \
    fonts-noto \
    gnome-tweaks
fi

echo ""
echo "Increasing the amount of inotify watchers"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p
