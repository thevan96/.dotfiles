# Config zsh
ZSH_THEME='robbyrussell'
DISABLE_AUTO_TITLE="true"

# Plugins
plugins=()

# Load zsh
source $ZSH/oh-my-zsh.sh

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
