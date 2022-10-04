NEWLINE=$'\n'
PROMPT="%F{green}%n@%m:%F{cyan}%~${NEWLINE}%F{reset_color}> "

# Load fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Load asdf cli manager
. $HOME/.asdf/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)
autoload -Uz compinit && compinit
