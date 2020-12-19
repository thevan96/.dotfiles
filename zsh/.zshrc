# Config zsh
ZSH_THEME="minimal"
DISABLE_AUTO_TITLE="true"

# Plugin
plugins=(vi-mode zsh-z tmux)
source $ZSH/oh-my-zsh.sh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

