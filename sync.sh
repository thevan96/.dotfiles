#!/bin/bash
ln -sf ~/dotfiles/nvim/init.vim ~/.config/nvim/init.vim
ln -sf ~/dotfiles/nvim/colors/base16-ocean-mono.vim ~/.config/nvim/colors/base16-ocean-mono.vim
ln -sf ~/dotfiles/nvim/coc-settings.json ~/.config/nvim/coc-settings.json
ln -sf ~/dotfiles/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sf ~/dotfiles/tmux/.tmux.conf ~/.tmux.conf
ln -sf ~/dotfiles/zsh/.zshrc ~/.zshrc
ln -sf ~/dotfiles/zsh/.zshenv ~/.zshenv
ln -sf ~/dotfiles/git/.gitconfig ~/.gitconfig

# snippet
ln -sf ~/dotfiles/UltiSnips/javascript.snippets ~/.config/nvim/UltiSnips/javascript.snippets
ln -sf ~/dotfiles/UltiSnips/php.snippets ~/.config/nvim/UltiSnips/php.snippets
ln -sf ~/dotfiles/UltiSnips/html.snippets ~/.config/nvim/UltiSnips/html.snippets

echo 'Sync done!'
