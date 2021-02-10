#!/bin/bash

# # -- brew install -- #
# brew install coreutils
# brew install alacritty
# brew install neovim
# brew install git
# brew install tree
# brew install tmux
# brew install fzf
# brew install neofetch
# brew install fd
# brew install rg
# brew install reattach-to-user-namespace
# brew install --HEAD neovim
# brew install gpg gpg2
# brew install --cask rectangle

# # -- apt install linux -- #
# sudo apt install tmux gpg git for linux curl wget dirmngr xclip g++ gcc uget transmission tree neofetch tmux neovim alacritty fzf

## -- Config zsh -- #
# chsh -s /bin/zsh # Set defautl zsh
# sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
# git clone https://github.com/agkozak/zsh-z $ZSH_CUSTOM/plugins/zsh-z

# # -- asdf config -- #
# git clone https://github.com/asdf-vm/asdf.git ~/.asdf
# cd ~/.asdf
# git checkout "$(git describe --abbrev=0 --tags)"
# cd ~/
# asdf plugin-add python
# pip3 install --user pynvim
# pip3 install Send2Trash

# asdf plugin-add nodejs https://github.com/asdf-vm/asdf-nodejs.git
# bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'
# asdf reshim nodejs

defaults write -g ApplePressAndHoldEnabled -bool false
echo "Fix repeat config key done!"

/usr/local/opt/fzf/install
echo 'fzf keybind done!'

mkdir -p ~/.config/nvim

# Setting link file
ln -sf ~/dotfiles/vimconf/.vimrc ~/.vimrc
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

ln -sf ~/dotfiles/UltiSnips/ ~/.config/nvim/
echo 'UltiSnips done!'

echo 'Sync success!'

