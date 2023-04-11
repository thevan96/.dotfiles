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

# Load version control information
autoload -Uz vcs_info
autoload -Uz compinit && compinit
zstyle ':vcs_info:*' enable git svn
zstyle ':vcs_info:*' check-for-changes true
zstyle ':vcs_info:*' unstagedstr ' /-'
zstyle ':vcs_info:*' stagedstr ' /-'
zstyle ':vcs_info:git:*' formats '[%b%u%c]'
zstyle ':vcs_info:git:*' actionformats '[%b%a%u%c]'
zstyle ':vcs_info:git*+set-message:*' hooks git-untracked

+vi-git-untracked(){
    if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) == 'true' ]] && \
        git status --porcelain | grep '??' &> /dev/null ; then
        hook_com[staged]+=' /~'
    fi
}

precmd() {
    vcs_info
}

PROMPT='%n@%m:%~ ${vcs_info_msg_0_}
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
