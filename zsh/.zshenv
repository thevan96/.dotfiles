# Configl zsh
ZSH_TMUX_AUTOSTART=false
ZSH_TMUX_AUTOQUIT=false
eval "$(starship init zsh)"
alias rlzsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias define shell
alias cl="clear"
alias ex="exit"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port "

# Alias tmux
alias kt="tmux kill-server"

# Alias tool
ua () {
  sudo apt -y update &&
  sudo apt -y upgrade &&
  sudo apt -y autoclean &&
  sudo apt -y autoremove &&
  cd $HOME/.nvm && git pull origin master &&
  cd $HOME/.oh-my-zsh && git pull origin master &&
  cd $HOME/.pyenv && git pull origin master &&
  cd $HOME/.rbenv && git pull origin master &&
  cd $HOME/flutter && git pull origin master &&
  cd
}

gam () {
  git add . && git commit --amend && git push --force
}

alias tv="ruby /opt/vim-plugins-profile-master/vim-plugins-profile.rb nvim"

bs () {
  browser-sync start --server --files '*' --port "${1:-3004}"
}

zeal-docs-fix () {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}

# Default vim text editor
export EDITOR=vi

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
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias run-phone="emulator @Pixel_3_API_28"


# Flutter, dart
export PATH="$PATH:$HOME/flutter/bin"

# Include Z
. /usr/local/bin/z.sh
