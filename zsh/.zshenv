# Alias define
alias lofi="tizonia --youtube-audio-mix https://www.youtube.com/watch\?v\=bebuiaSKtU4"
alias falloutboy="tizonia --youtube-audio-mix https://www.youtube.com/watch\?v\=LBr7kECsjcQ\&list\=OLAK5uy_ltl03A3bXBWEfk1Weu5PgBD1Hs_VJkWas"
alias nujabes="tizonia --youtube-audio-playlist https://www.youtube.com/watch\?v\=_qU2MXeAz1E\&list\=PLpleWfPiCfvaeKJdaieurunjfUc9NpjDE\&index\=3"
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
alias tm-begin="tmux new -s Coding -n Main"
alias tm-kill="tmux kill-session -a"

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
export FZF_DEFAULT_COMMAND='fd --type file --follow --hidden --exclude .git'

# To apply the command to CTRL-T as well
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height --no-reverse'
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Include Z
. /usr/local/bin/z.sh

