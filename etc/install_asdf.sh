#!/usr/bin/env bash

# Insall depencies

## Nodejs
sudo apt -y install python3 g++ make python3-pip

## Python
sudo apt -y install build-essential libssl-dev zlib1g-dev \
libbz2-dev libreadline-dev libsqlite3-dev curl \
libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

## Golang
sudo apt install -y coreutils curl

dir_asdf="$HOME/.asdf/"
if [ ! -d "$dir_asdf" ]; then
  rm -rf $dir_asdf
  echo "Installing asdf ..."
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  . "$HOME/.asdf/asdf.sh"
fi

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add python
asdf plugin-add rust https://github.com/asdf-community/asdf-rust.git
asdf plugin add golang https://github.com/asdf-community/asdf-golang.git
echo 'asdf install plugins done!'

# asdf install nodejs latest:18
# asdf global nodejs latest:18
#
# asdf install python latest
# asdf global python latest
#
# asdf install golang latest
# asdf global golang latest
#
# asdf install rust latest
# asdf global rust latest
