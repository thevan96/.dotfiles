#!/bin/bash
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

# Config file global bin
sudo ln -sf ~/dotfiles/etc/fix-git /usr/local/bin
echo 'file execute done!'

# Setup python
python3 -m pip install --user --upgrade pynvim
python2 -m pip install --user --upgrade pynvim
python -m pip install --user --upgrade pynvim
pip3 install --user pynvim neovim Send2Trash
pip2 install --user pynvim neovim Send2Trash
pip install --user pynvim neovim Send2Trash
echo 'python done!'

# Setup npm
npm i -g prettier nodemon kill-port react-native-cli\
  create-react-app yarn tldr neovim standard semistandard import-js
echo 'npm done!'

# Setup ruby
gem install neovim

echo 'Sync success!'
