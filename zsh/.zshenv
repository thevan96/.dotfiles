# Config zsh
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Auto open zsh
# ZSH_TMUX_AUTOSTART="true"

# Alias tool
alias ex="exit"
alias cl="clear"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias vi="nvim"

fix-git() {
  ssh-add $HOME/.ssh/id_rsa_github $HOME/.ssh/id_rsa_gitlab
}

ide () {
  tmux split-window -v -p 20
  tmux split-window -h -p 50
}

git-search () {
  git log --all --grep="${1}"
}

bs () {
  browser-sync start --server --files --files "**/*.*" --port ${1}
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

# Vscode
export PATH="/Applications/Visual Studio Code.app/Contents/Resources/app/bin:$PATH"
