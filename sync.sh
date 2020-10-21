#!/bin/bash

# Install brew package
# brew install coreutils curl gpg asdf zsh git tig tmux fd ripgrep nvim tree neofetch fzf reattach-to-user-namespace
# brew cask install vlc joplin sublime-text visual-studio-code skype firefox google-chrome blender alacritty
# echo "Install brew package done"

# Setup python
# pip install --upgrade pip
# pip3 install --user pynvim neovim Send2Trash
# echo 'python done!'

# Setup npm
# npm i -g prettier nodemon kill-port react-native browser-sync\
#  create-react-app tldr neovim standard semistandard
# echo 'npm done!'

defaults write -g ApplePressAndHoldEnabled -bool false
echo "repeat config key done!"

# Setting link file
mkdir -p ~/.config/nvim

ln -sf ~/dotfiles/vimconf/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vimconf/coc-settings.json ~/.config/nvim/coc-settings.json
echo 'vim done!'

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo 'tmux done!'

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
echo 'zsh done!'

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
echo 'git done!'

ln -sf ~/dotfiles/alacritty ~/.config/
echo 'alacritty done!'

/usr/local/opt/fzf/install
echo 'fzf keybind done!'

echo 'Sync success!'

