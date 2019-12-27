# Alias define
alias cl="clear"
alias ex="exit"
alias update-all="sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoclean && sudo apt -y autoremove"
alias standard-log="standard --fix | snazzy"
alias npmplease="rm -rf node_modules && rm package-lock.json && npm install"
alias rl-zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias hc="history -c"
alias bs="browser-sync start --server --files '*' --port "
alias find-port="sudo lsof -i -P -n"
alias test-vim="ruby /opt/vim-plugins-profile-master/vim-plugins-profile.rb nvim"
alias kill-tmux="tmux kill-server"
alias phpload="composer dump-autoload"

rp (){
  php -S localhost:"$1"
}

zeal-docs-fix () {
    pushd "$HOME/.local/share/Zeal/Zeal/docsets" >/dev/null || return
    find . -iname 'react-main*.js' -exec rm '{}' \;
    popd >/dev/null || exit
}

git-amend () {
  git add .
  git commit --amend
  ggp --force
}

# Default vim text editor
export EDITOR=vi

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

# PHP composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

# FZF
# Setting fd as the default source for fzf
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git --exclude node_modules --color always'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height --no-reverse --ansi'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export XDEBUG_CONFIG="idekey=xdebug"

# Include Z
. /usr/local/bin/z.sh

