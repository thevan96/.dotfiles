# Config plugin zsh
ZSH_TMUX_AUTOSTART=true

# Config starship shell zsh
eval "$(starship init zsh)"

# Alias define shell
alias cl="clear"
alias ex="exit"
alias mkdir="mkdir -p"
alias hc="history -c"
alias find-port="sudo lsof -i -P -n"

# Alias define git
alias gs="git status"
alias ga="git add "
alias gl="git log"
alias gd="git diff"
alias glo="git log --oneline"
alias gca="git commit --amend"
alias gc="git commit -m "
alias grh="git reset --hard"
gp (){
  git push origin "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)"
}
gpf (){
  git push origin "$(git rev-parse --symbolic-full-name --abbrev-ref HEAD)" --force
}

# Alias tool
alias update-all="sudo apt -y update && sudo apt -y upgrade && sudo apt -y autoclean && sudo apt -y autoremove"
alias standard-log="standard --fix | snazzy"
alias npmplease="rm -rf node_modules && rm package-lock.json && npm install"
alias rl-zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias bs="browser-sync start --server --files '*' --port "
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

# Default vim text editor
export EDITOR=vi

# Config vimdebug php
export XDEBUG_CONFIG="idekey=xdebug"

# Laravel export
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# PHP composer
export PATH="$PATH:$HOME/.composer/vendor/bin"

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
export FZF_DEFAULT_COMMAND='fd --type file --hidden --exclude .git --exclude node_modules --color always'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height --no-reverse --ansi'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Include Z
. /usr/local/bin/z.sh

