#!/bin/bash

# Setting link file
mkdir -p ~/.config/nvim

ln -sf ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json
echo 'vim done!'

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo 'tmux done!'

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
echo 'zsh done!'

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
echo 'git done!'

ln -sf ~/dotfiles/mycli/.myclirc ~/.myclirc
echo 'mycli done!'

ln -sf ~/dotfiles/alacritty ~/.config/
echo 'alacritty done!'

# Install brew package
brew install tig tmux fd ripgrep nvim tree neofetch fzf
brew cask install firefox google-chrome alacritty blender vlc

# Setup python
pip install --upgrade pip
python3 -m pip install --user --upgrade pynvim
pip3 install --user pynvim neovim Send2Trash
echo 'python done!'

# Setup npm
npm i -g prettier nodemon kill-port react-native browser-sync\
  create-react-app yarn tldr neovim standard semistandard import-js
echo 'npm done!'

echo 'Sync success!'
