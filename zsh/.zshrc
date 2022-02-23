# Config zsh
ZSH_THEME="robbyrussell"
DISABLE_AUTO_TITLE="true"

# Load zsh
source $ZSH/oh-my-zsh.sh

# Load z jump directory
. ~/.local/bin/z

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
. $HOME/.asdf/completions/asdf.bash
