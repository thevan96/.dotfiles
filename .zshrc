# zsh option conf
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE=~/.zsh_history

PROMPT='%F{green}%n@%m:%F{cyan}%~ $(indicator_git)%F{reset_color}
$ '

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
