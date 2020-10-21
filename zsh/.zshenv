# Set env variable
export ZSH="$HOME/.oh-my-zsh"
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR=vi
export TERM="screen-256color"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f -i -H -I \
  --exclude .git --exclude node_modules --exclude vendor --exclude .idea'
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
alias ex="exit"
alias cl='clear'
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias vi='nvim'
alias rm='rm -rf'

# Mirrow phone
alias rp="scrcpy --turn-screen-off"

pwdc() {
  pwd | pbcopy # macos
  # pwd | xsel --clipboard # linux
}

bs() {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

github() {
  ssh-add $HOME/.ssh/github
}

gitlab() {
  ssh-add $HOME/.ssh/gitlab
}

