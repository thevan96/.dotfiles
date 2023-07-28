#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  # Update/upgrade/install
  sudo dnf -y update && sudo dnf -y upgrade && sudo dnf install \
    util-linux-user \
    pgcli \
    mycli \
    gcc \
    g++ \
    tree \
    neofetch \
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
    unrar \
    zip \
    ibus \
    xsel \
    xclip \
    wmctrl \
    stow \
    neovim \
    alacritty \
    rofi \
    vlc \
    gimp \
    gpick \
    uget \
    flameshot \
    gparted \
    screenkey \
    simplescreenrecorder \
    timeshift \
    transmission \
    peek \
    obs-studio \
    gnome-extensions-app \
    gnome-clocks \
    gnome-tweaks \
    dconf-editor \
    plantuml \
    chrome-gnome-shell
fi

echo ""
echo "Increasing the amount of inotify watchers"
echo fs.inotify.max_user_watches=524288 | sudo tee -a /etc/sysctl.conf && sudo sysctl -p

# Export
# dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > custom_shortcut
echo "Import custom shortcuts"
cat ~/.dotfiles/etc/custom_shortcut | dconf load /org/gnome/settings-daemon/plugins/media-keys/

# Make alias
if [ ! -f "nvim" ]; then
  sudo ln -sf $(which nvim) /usr/local/bin/vim
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
# gsettings reset org.gnome.mutter overlay-key
# gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
