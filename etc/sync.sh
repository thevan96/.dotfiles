#!/bin/bash

mkdir -p ~/.config/nvim
mkdir -p ~/.config/pgcli
mkdir -p ~/.local/bin
mkdir -p ~/.fonts

# Gnome setup
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true

# Setting link file
ln -sf ~/.dotfiles/etc/sync_note.sh ~/.local/bin/sync_note
echo 'sync note done'

ln -sf ~/.dotfiles/vimconf/.vimrc ~/.vimrc
ln -sf ~/.dotfiles/vimconf/init.vim ~/.config/nvim/init.vim
ln -sf ~/.dotfiles/vimconf/lua ~/.config/nvim/
echo 'vim done!'

ln -sf ~/.dotfiles/etc/postman.desktop ~/.local/share/applications/postman.desktop
ln -sf ~/.dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/.dotfiles/etc/ibus_tmux.sh ~/.local/bin/ibus_tmux
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
echo 'ultisnips done!'

ln -sf ~/.dotfiles/myFonts/ ~/.fonts/
echo 'setting fonts done!'

echo 'sync success!'
