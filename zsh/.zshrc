# Config zsh
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Option
DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_TITLE="true"

# Plugin
plugins=(vi-mode zsh-z tmux)
source $ZSH/oh-my-zsh.sh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
