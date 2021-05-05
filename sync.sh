#!/bin/bash

# Asdf update
asdf reshim nodejs
asdf reshim python
asdf reshim ruby
asdf reshim rust
echo 'asdf done!'

mkdir -p ~/.config/rubocop
mkdir -p ~/.config/nvim

# Setting link file
ln -sf ~/dotfiles/vimconf/.vimrc ~/.vimrc
ln -sf ~/dotfiles/vimconf/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vimconf/coc-settings.json ~/.config/nvim/coc-settings.json
echo 'vim done!'

ln -sf ~/dotfiles/etc/.rubocop.yml ~/.config/rubocop/.rubocop.yml
echo 'rubocop done!'

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo 'tmux done!'

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
echo 'zsh done!'

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
echo 'git done!'

ln -sf ~/dotfiles/alacritty ~/.config/
echo 'alacritty done!'

ln -sf ~/dotfiles/sql/.myclirc ~/.myclirc
ln -sf ~/dotfiles/sql/.my.cnf ~/.my.cnf
echo 'SQL done!'

ln -sf ~/dotfiles/UltiSnips/ ~/.config/nvim/
echo 'UltiSnips done!'

echo 'Sync success!'
