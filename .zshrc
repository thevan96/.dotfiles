# zsh option conf
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE=~/.zsh_history

indicator_git() {
  branch=$(git symbolic-ref HEAD 2> /dev/null | cut -d'/' -f3)
  if [[ $branch != '' ]]; then
    out=$(git status --short)
    if [[ $out != '' ]]; then
      echo "[$branch*]"
    else
      echo "[$branch]"
    fi
  fi
}

PROMPT='%n@%m:%~$(indicator_git)
$ '

# Enable vi mode
bindkey -v

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
