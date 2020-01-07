# Config plugin zsh
ZSH_TMUX_AUTOSTART=false

# Config starship shell zsh
eval "$(starship init zsh)"
alias reload-zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Alias define shell
alias cl="clear"
alias ex="exit"
alias ..="cd .."
alias mkdir="mkdir -p"
alias hc="history -c"
alias find-port="sudo lsof -i -P -n"

# Alias tmux
alias kp="kill-port "
alias tk="tmux kill-server"

# Alias define git
alias gs="git status"
alias ga="git add "
alias gl="git log"
alias gd="git diff"
alias glo="git log --oneline"
alias gca="git commit --amend"
alias gc="git commit -m "
alias grh="git reset --hard"
gpl (){
  git pull origin "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
}
gps (){
  git push origin "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
}
gpsf (){
  git push origin "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" --force
}
git-amend (){
  ga . && gca && gpsf
}
# Alias php
rp() {
  php -S localhost:"$1"
}

# Alias tool
update-all() {
  sudo apt -y update &&
  sudo apt -y upgrade &&
  sudo apt -y autoclean &&
  sudo apt -y autoremove &&
  cd $HOME/.nvm && git pull origin master &&
  cd $HOME/.oh-my-zsh && git pull origin master &&
  cd $HOME/.pyenv && git pull origin master &&
  cd $HOME/.rbenv && git pull origin master &&
  cd
}
alias standard-log="standard --fix | snazzy"
alias npmplease="rm -rf node_modules && rm package-lock.json && npm install"
alias bs="browser-sync start --server --files '*' --port "
alias test-vim="ruby /opt/vim-plugins-profile-master/vim-plugins-profile.rb nvim"
zeal-docs-fix() {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}

# Default vim text editor
export EDITOR=vi

# Config vimdebug php
export XDEBUG_CONFIG="idekey=xdebug"

# Laravel export, composer
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
export FZF_DEFAULT_COMMAND='fd --type file -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea --color always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height --no-reverse --ansi'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias run-phone="emulator @Pixel_2_XL_API_28"

# Include Z
. /usr/local/bin/z.sh

