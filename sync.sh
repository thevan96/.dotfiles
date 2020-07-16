#!/bin/bash
mkdir -p ~/.config/{nvim,alacritty}

echo 'Vim done!'
ln -sf ~/dotfiles/vim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/vim/coc-settings.json ~/.config/nvim/coc-settings.json

ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
echo 'Tmux done!'

ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
echo 'ZSH done!'

ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig
ln -sf ~/dotfiles/git/.gitignore_global ~/.gitignore_global
echo 'Git done!'

ln -sf ~/dotfiles/mycli/.myclirc ~/.myclirc
echo 'Mycli done!'

ln -sf ~/dotfiles/etc/config.rasi ~/.config/rofi/
echo 'Rofi done!'

ln -sf ~/dotfiles/etc/kitty.conf ~/.config/kitty/
echo 'Kitty done!'

# Config file global bin
sudo ln -sf ~/dotfiles/etc/z.sh /usr/local/bin
sudo ln -sf ~/dotfiles/etc/fullscreen.sh /usr/local/bin
sudo ln -sf ~/dotfiles/etc/fix-git.sh /usr/local/bin
sudo ln -sf ~/dotfiles/etc/memory.sh /usr/local/bin

echo 'File execute done!'

echo 'Sync done!'
