# Config zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"

# Plugin
plugins=(vi-mode zsh-z tmux)
source $ZSH/oh-my-zsh.sh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

