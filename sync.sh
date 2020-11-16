#!/bin/bash

# asdf config
# asdf plugin-add ruby https://github.com/asdf-vm/asdf-ruby.git
# asdf plugin-add python
# asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

defaults write -g ApplePressAndHoldEnabled -bool false
echo "repeat config key done!"

/usr/local/opt/fzf/install
echo 'fzf keybind done!'

mkdir -p ~/.config/nvim

# Setting link file
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

ln -sf ~/dotfiles/UltiSnips ~/.config/nvim/
echo 'UltiSnips done!'

echo 'Sync success!'
