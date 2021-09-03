#  Export env variable
export EDITOR="nvim"
export KEYTIMEOUT=1
export NIXPKGS_ALLOW_UNFREE=1
export RUBYOPT="-W:no-deprecated"
export TERM="screen-256color"
export ASDF_GOLANG_VERSION=1.17.7

# DEFAULT EVIROMENT
export ZSH="$HOME/.oh-my-zsh"
export GOROOT="$HOME/.asdf/installs/golang/${ASDF_GOLANG_VERSION}/go"
export ANDROID_HOME=$HOME/Android/Sdk
# export ANDROID_HOME=$HOME/Library/Android/sdk

# ADD PATH
export PATH="$HOME/.local/bin:$PATH"
export PATH=$PATH:"$HOME/.asdf/installs/golang/${ASDF_GOLANG_VERSION}/packages/bin"
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# Alias
alias cl="clear"
alias vim="nvim"
alias lg="lazygit"
alias ld="lazydocker"
alias hc="history -c"
alias vimdiff="nvim -d"
alias nnn="NNN_TRASH=1 nnn -doeH"
alias rails_db="rails db:drop db:create db:migrate db:seed"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias music_coding="mpv --no-video 'https://www.youtube.com/watch?v=5yx6BWlEVcY' --volume=35"

sys_update() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove \
}

bs() {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

asdf_update() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim ruby
  asdf reshim rust
  asdf reshim golang
  echo 'Asdf update done !'
}

ssh_update() {
  ssh-add ~/.ssh/github_personal
}

ide() {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}
