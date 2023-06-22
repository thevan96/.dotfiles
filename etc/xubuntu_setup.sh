#!/usr/bin/env bash

if [[ "$OSTYPE" == "linux-gnu"* ]]; then

  sudo apt remove xfce4-screensaver

  # Update/upgrade/install
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
    rar \
    unrar \
    zip \
    ibus \
    xsel \
    xclip \
    wmctrl \
    pgcli \
    mycli \
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
    msttcorefonts \
    timeshift \
    trash-cli \
    rofi \
    light-locker \
    transmission
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
if [ ! -f "fdfind" ]; then
  sudo ln -sf $(which fdfind) ~/.local/bin/fd
fi

if [ ! -f "nvim" ]; then
  sudo ln -sf $(which nvim) ~/.local/bin/vi
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
