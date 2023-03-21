# zsh option conf
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE=~/.zsh_history

# Key bindings
bindkey -v # vi-mode / bindkey -e # emacs
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line

PROMPT='%n@%m:%~
$ '

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh

# Setup ssh
if [[ $XDG_CURRENT_DESKTOP == 'i3' || $XDG_CURRENT_DESKTOP == '' ]]; then
  eval `keychain --eval --agents ssh id_rsa_github_personal --quick --quiet`
  clear
fi
