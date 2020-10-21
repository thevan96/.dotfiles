# Config zsh
ZSH_THEME="robbyrussell"

# Option config
ZSH_TMUX_AUTOSTART=true

# Plugin
plugins=(vi-mode zsh-z tmux)
source $ZSH/oh-my-zsh.sh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh

# Enable fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
