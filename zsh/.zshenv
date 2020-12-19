# Export path, env variable
export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export TERM="screen-256color"
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR=nvim

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# FZF
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND=" fd --type f -i -H -I \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
    "

zle -N fzf-cd-widget
bindkey '^Y' fzf-cd-widget

# Git
alias github="ssh-add $HOME/.ssh/github"
alias gitlab="ssh-add $HOME/.ssh/gitlab"

# Emulator
alias listSimulator="xcrun simctl list devices"
alias listEmulator="emulator -list-avds"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Alias
alias ..="cd .."
alias ..2="cd ../.."
alias ..3="cd ../../.."
alias ..4="cd ../../../.."
alias ..5="cd ../../../../.."
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias vi="nvim"
alias rp="scrcpy --turn-screen-off"
alias note="cd $HOME/notes && vi"

bs () {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

pf () {
  pwd | pbcopy
  # pwd | xsel --clipboard # linux
}

ps () {
  echo "${PWD##*/}" | pbcopy
}

