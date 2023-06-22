#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  # Update/upgrade/install
  sudo dnf -y update && sudo dnf -y upgrade && sudo dnf install \
    util-linux-user \
    pgcli \
    mycli \
    postgresql \
    mysql \
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
    blender \
    gimp \
    gpick \
    inkscape \
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
    gnome-pomodoro
fi

# Change shell
echo ""
echo "Switch to zsh ..."
chsh -s $(which zsh)

# Create folder
folders=(
  "${HOME}/Personal"
  "${HOME}/OSS"
  "${HOME}/Company"
  "${HOME}/.config/autostart",
)

for el in ${folders[@]}; do
  if [ ! -d $el ]; then
    mkdir $el
  fi
done

# Make alias
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
# gsettings reset org.gnome.mutter overlay-key
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter dynamic-workspaces false
