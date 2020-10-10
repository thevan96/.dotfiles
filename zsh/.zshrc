# Config zsh
export ZSH="/Users/thevan96/.oh-my-zsh"
ZSH_THEME="robbyrussell"

# Option
DISABLE_UPDATE_PROMPT="true"
DISABLE_AUTO_TITLE="true"

# Plugin
plugins=(vi-mode zsh-z)
source $ZSH/oh-my-zsh.sh

# Load asdf cli manager
. $(brew --prefix asdf)/asdf.sh

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
