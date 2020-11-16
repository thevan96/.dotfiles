# Set env variable
export ZSH="$HOME/.oh-my-zsh"
export TERM="screen-256color"
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR=nvim

# FZF
export FZF_DEFAULT_COMMAND="fd --type f -i -H -I \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
    "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Emulator
alias listSimulator="xcrun simctl list devices"
alias listEmulator="emulator -list-avds"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Alias
alias cl="clear"
alias ex="exit"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias vi="nvim"
alias vim="nvim"
alias github="ssh-add $HOME/.ssh/github"
alias gitlab="ssh-add $HOME/.ssh/gitlab"
alias pwdf="pwd | pbcopy" # pwd | xsel --clipboard # linux
alias rp="scrcpy --turn-screen-off" # Mirrow phone

# Live reload browser
bs() {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

pwds() {
  echo "${PWD##*/}" | pbcopy
}

