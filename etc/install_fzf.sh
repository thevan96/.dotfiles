#!/usr/bin/env bash

dir_fzf="$HOME/.fzf/"
if [ ! -d "$dir_fzf" ]; then
  rm -rf $dir_fzf
  echo "Installing fzf ..."
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install
fi
