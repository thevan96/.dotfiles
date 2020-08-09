# Config zsh
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias tool
alias ex="exit"
alias cl="clear"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias cat="bat"
alias dvApple="xcrun simctl list devices"
 
git-search () {
  git log --all --grep="${1}"
}

keep-android () {
  wmctrl -i -r $(wmctrl -l | grep ' Android Emulator - ' |
  sed -e 's/\s.*$//g') -b toggle,above
}

# Set env variable
export KEYTIMEOUT=1
export EDITOR=vi
export TERM="screen-256color"

# FZF
export FZF_DEFAULT_COMMAND='fd --type f -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height'

# Bison 
export PATH="/usr/local/opt/bison/bin:$PATH"

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"
alias rp="scrcpy --turn-screen-off"
