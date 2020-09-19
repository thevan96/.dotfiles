# Config zsh
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Set env variable
export LANG=en_US.UTF-8
export KEYTIMEOUT=1
export EDITOR=vi
export TERM="screen-256color"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height'

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Mirrow phone
alias rp="scrcpy --turn-screen-off"

# Emulator
alias listEmulator="emulator -list-avds"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Simulator
alias listSimulator="xcrun simctl list devices"

# export program
export PATH="/usr/local/opt/bison/bin:$PATH"

# Alias tool
alias ex="exit"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias vi="nvim"

fix-git() {
  ssh-add $HOME/.ssh/github $HOME/.ssh/gitlab
}

bs () {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

