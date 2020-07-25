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

ln -sf ~/dotfiles/etc/kitty.conf ~/.config/kitty/
echo 'kitty done!'

ln -sf ~/dotfiles/UltiSnips ~/.config/nvim/
echo 'snippets done!'

# Program
sudo apt install -y g++ gcc tree nano bat htop neofetch fzf fonts-firacode\
  curl uget openjdk-8-jdk openjdk-8-jre blender uget ripgrep\
  transmission gimp inkscape flameshot skypeforlinux slack-desktop

# Config file global bin
sudo ln -sf ~/dotfiles/etc/z.sh /usr/local/bin
sudo ln -sf ~/dotfiles/etc/fix-git.sh /usr/local/bin
sudo ln -sf ~/dotfiles/etc/memory.sh /usr/local/bin
echo 'file execute done!'

# Setup python
python3 -m pip install --user --upgrade pynvim
pip3 install --user pynvim
pip install Send2Trash
echo 'python done!'

# Setup npm
npm i -g prettier nodemon kill-port react-native-cli create-react-app yarn tldr neovim standard semistandard
echo 'npm done!'

echo 'Sync success!'
