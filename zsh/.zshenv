# Config zsh
alias reload-zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias define shell
alias ex="exit"
alias cl="clear"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port "

# tmux
alias kw="tmux kill-window"
alias kp="tmux kill-pane"
alias kt="tmux kill-server"
alias ks="tmux kill-session"
alias ta="tmux attach"
alias tm="tmux"

# Alias tool
alias emacs="emacs -nw"
alias note="cd ~/Notes && vim"
alias code="code --disable-gpu"

ide () {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}

ua () {
    sudo apt -y update &&
    sudo apt -y upgrade &&
    sudo apt -y autoremove &&
    sudo apt -y autoclean &&
    cd $HOME/.nvm && git pull origin master &&
    cd $HOME/.oh-my-zsh && git pull origin master &&
    cd $HOME/.pyenv && git pull origin master &&
    cd $HOME/.rbenv && git pull origin master &&
    cd $HOME/.fzf && git pull origin master &&
    cd
}

alias tv="ruby /opt/vim-plugins-profile/vim-plugins-profile.rb nvim"

bs () {
  browser-sync start --server --files '*' --port "${1:-3004}"
}

fix-zeal() {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}

# Set env variable
export KEYTIMEOUT=1
export EDITOR=vim
export TERM="screen-256color"

# File excute
export PATH="$HOME/.bin:$PATH"

# Laravel export, composer, php
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# Rubyenv
export RUBYENV_ROOT="$HOME/.rbenv/"
export PATH="$RUBYENV_ROOT/bin:$PATH"
eval "$(rbenv init -)"

# NVM - Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
export FZF_DEFAULT_COMMAND='fd --type f -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height'

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias run-phone="emulator @Pixel_3_API_28"

# Flutter, dart
export PATH="$PATH:$HOME/flutter/bin"
export DART_ROOT="$HOME/dart-sdk"
export PATH="$DART_ROOT/bin:$PATH"

# Include Z
. /usr/local/bin/z.sh
