# Config zsh
alias rlzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias define shell
alias cl="clear"
alias ex="exit"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port "

# Alias tool
ua () {
  sudo apt -y update &&
  sudo apt -y upgrade &&
  sudo apt -y autoremove &&
  sudo apt -y autoclean &&
  cd $HOME/.nvm && git pull origin master &&
  cd $HOME/.oh-my-zsh && git pull origin master &&
  cd $HOME/.pyenv && git pull origin master &&
  cd $HOME/.rbenv && git pull origin master &&
  cd $HOME/flutter && git pull origin master &&
  cd $HOME/.fzf && git pull origin master &&
  cd
}

# Help
hp () {
  tldr "${1}"
}

alias tv="ruby /opt/vim-plugins-profile-master/vim-plugins-profile.rb nvim"

bs () {
  browser-sync start --server --files '*' --port "${1:-3004}"
}

# Default vim text editor & enable vi mode in zsh
export KEYTIMEOUT=1
export EDITOR=vim

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
export FZF_DEFAULT_COMMAND='fd --type f -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea --color=always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height --ansi'

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
# . /usr/local/bin/z.sh
