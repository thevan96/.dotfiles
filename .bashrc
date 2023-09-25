# Bash config variable
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Load alias
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# GIT
GIT_PS1_SHOWDIRTYSTATE='y'
GIT_PS1_SHOWSTASHSTATE='y'
GIT_PS1_SHOWUNTRACKEDFILES='y'
GIT_PS1_DESCRIBE_STYLE='contains'
GIT_PS1_SHOWUPSTREAM='auto'
PS1='\u@\H: \w$(__git_ps1)\n\\$ '

# Enable git prompt
source /etc/bash_completion.d/git-prompt

# Enable bash autocomplete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load fzf
[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Load asdf cli manager
. "$HOME/.asdf/asdf.sh"
. "$HOME/.asdf/completions/asdf.bash"

# Setup ssh with keychain
if [[ $XDG_CURRENT_DESKTOP == 'i3' || $XDG_CURRENT_DESKTOP == 'ubuntu:GNOME' ]]; then
  eval `keychain --noask --eval --agents ssh id_rsa_github_personal --quick --quiet`
fi
