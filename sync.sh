#!/bin/bash

# Asdf install plugin
asdf plugin add nodejs
asdf plugin add ruby
asdf plugin add python
asdf plugin add rust
echo 'asdf done!'

mkdir -p ~/.config/rubocop
mkdir -p ~/.config/nvim

# Setting link file
ln -sf ~/.dotfiles/vimconf/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vimconf/init.vim ~/.config/nvim/init.vim
ln -sf ~/.dotfiles/vimconf/coc-settings.json ~/.config/nvim/coc-settings.json
echo 'vim done!'

ln -sf ~/.dotfiles/etc/.rubocop.yml ~/.config/rubocop/.rubocop.yml
echo 'rubocop done!'

ln -sf ~/.dotfiles/etc/.inputrc ~/.inputrc
echo '.inputrc done!'

ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo 'tmux done!'

ln -sf ~/.dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/.dotfiles/zsh/.zshenv ~/.zshenv
echo 'zsh done!'

ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/.dotfiles/git/.gitignore_global ~/.gitignore_global
echo 'git done!'

ln -sf ~/.dotfiles/alacritty ~/.config/
echo 'alacritty done!'

ln -sf ~/.dotfiles/sql/.myclirc ~/.myclirc
ln -sf ~/.dotfiles/sql/.my.cnf ~/.my.cnf
ln -sf ~/.dotfiles/sql/config ~/.config/pgcli/config
echo 'sql done!'

ln -sf ~/.dotfiles/UltiSnips/ ~/.config/nvim/
ln -sf ~/.dotfiles/UltiSnips/ ~/.vim/
echo 'ultisnips done!'

echo 'sync success!'
