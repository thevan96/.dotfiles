# Config zsh
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias tool
alias ex="exit"
alias cl="clear"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias cat="bat"

git-search () {
  git log --all --grep="${1}"
}

# Set env variable
export LANG=en_US.UTF-8
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

# Mirrow phone
alias rp="scrcpy --turn-screen-off"

# Run emulator 
alias listEmulator="emulator -list-avds"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Run simulator
alias listSimulator="xcrun simctl list devices"
alias iphone5="xcrun simctl boot DD956CC3-5A04-4295-A51F-FBC31E8A737A"
alias iphone8="xcrun simctl boot 772DF788-738B-42E7-BF55-137A6C999340"
alias iphone11="xcrun simctl boot 678A4228-5AB3-4932-ACCF-B9B988AF732D"
alias iphonex="xcrun simctl boot DF736FB6-4A0F-489B-B958-A28197749C4B"
alias ipad="xcrun simctl boot C332080B-C275-40CA-B15B-3F334860C101"
