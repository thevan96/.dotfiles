# zsh option conf
setopt PROMPT_SUBST
setopt INC_APPEND_HISTORY
setopt HIST_FIND_NO_DUPS
setopt HIST_IGNORE_ALL_DUPS

export SAVEHIST=10000
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTFILE=~/.zsh_history

# Load version control information
autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr '~'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '[%b%u%c]'
zstyle ':vcs_info:git:*' actionformats '[%b%a%u%c]'

precmd() {
    vcs_info
}

PROMPT='%~ ${vcs_info_msg_0_}
$ '

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
