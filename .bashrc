# Bash config variable
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Load alias
if [ -f ~/.bash_aliases ]; then
  source "$HOME/.bash_aliases"
fi

# PS1
PS1='\w\n\\$ '

# Vi-mode
set -o vi
bind '"\C-l": clear-screen'
# bind '"\C-x\C-e": edit-and-execute-command'

# Load nix
if [ -f ~/.nix-profile/etc/profile.d/nix.sh ]; then
  source "$HOME/.nix-profile/etc/profile.d/nix.sh"
fi

# Enable bash autocomplete
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    source /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    source /etc/bash_completion
  fi
fi

# Enable git prompt
if [ -f /usr/share/git-core/contrib/completion/git-prompt.sh ]; then
  source /usr/share/git-core/contrib/completion/git-prompt.sh
fi

# Load direnv
if command -v direnv &> /dev/null; then
  eval "$(direnv hook bash)"
fi

# Load fzf
if command -v fzf &> /dev/null; then
  source /usr/share/fzf/shell/key-bindings.bash
fi

# Load z
if command -v z &> /dev/null; then
  source ~/.local/bin/z
fi
