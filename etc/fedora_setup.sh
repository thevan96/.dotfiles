#!/usr/bin/env bash
set -e

if [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Enable rpmfusion
  sudo dnf -y install https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm

  # Add repo vscode
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
  sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'

  sudo dnf -y update && sudo dnf -y upgrade && sudo dnf install -y \
    brightnessctl \
    curl \
    entr \
    fd-find \
    fzf \
    git \
    htop \
    jq \
    make \
    mycli \
    nano \
    neofetch \
    neovim \
    net-tools \
    pgcli \
    ripgrep \
    rofi \
    stow \
    tig \
    tmux \
    trash-cli \
    tree \
    unrar \
    vim \
    wget \
    wmctrl \
    xsel \
    zip

  sudo dnf install -y \
    alacritty \
    code \
    dropbox \
    evince \
    flameshot \
    gimp \
    gnome-sound-recorder \
    gparted \
    gpick \
    libreoffice \
    obs-studio \
    peek \
    screenkey \
    simplescreenrecorder \
    timeshift \
    transmission \
    uget \
    vlc

  # codec
  sudo dnf -y swap ffmpeg-free ffmpeg --allowerasing

  echo ""
  echo "Increasing the amount of inotify watchers"
  echo fs.inotify.max_user_watches=524288 \
    | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

  echo "Set timezone"
  timedatectl set-timezone 'Asia/Ho_Chi_Minh'

  echo "Set namehost"
  sudo hostnamectl set-hostname elliot
fi
