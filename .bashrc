# Bash config variable
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Load alias
if [ -f ~/.bash_aliases ]; then
  . "$HOME/.bash_aliases"
fi

# PS1
PS1='\u@\H:\w\n\\$ '

# Vi-mode
set -o vi
bind -m vi-command 'Control-l: clear-screen'
bind -m vi-insert 'Control-l: clear-screen'

# Load nix
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
  . "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Enable bash autocomplete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Enable git prompt
source /etc/bash_completion.d/git-prompt

# Load direnv
eval "$(direnv hook bash)"

# Load fzf
if [ -f ~/.fzf.bash ]; then
  . "$HOME/.fzf.bash"
fi

# Setup ssh with keychain
if [ $XDG_CURRENT_DESKTOP == 'i3' ]; then
  eval `keychain --noask --eval --agents ssh id_rsa_github_personal --quick --quiet`
fi
