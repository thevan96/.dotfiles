#!/bin/bash
mkdir -p ~/.config/{nvim/UltiSnips,alacritty}

ln -sf ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

ln -sf ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

ln -sf ~/dotfiles/mycli/.myclirc ~/.myclirc

echo 'Sync done!'
