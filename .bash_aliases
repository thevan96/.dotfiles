#  Export env variable
export EDITOR=vim
export KEYTIMEOUT=1
export TERM=screen-256color
export MANPAGER="vim '+set nonumber' +Man!"

# DEFAULT EVIROMENT
export XDG_CONFIG_HOME=$HOME/.config
export ANDROID_HOME=$HOME/Android/Sdk
export ASDF_GOLANG_MOD_VERSION_ENABLED=false

# macos export ANDROID_HOME=$HOME/Library/Android/sdk

# ADD PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# FZF
export FZF_DEFAULT_COMMAND="fd --type f -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_ALT_C_COMMAND="fd --type d -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Alias
alias ls='ls --color=always'
alias pwdcp='pwd | xclip -selection clipboard'
alias reload_zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Utils
exit() {
  echo 'Use <C-d> instead!'
}

mkdircd() {
  mkdir -p ${1} && cd ${1}
}

update_asdf() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim rust
  asdf reshim golang
  echo 'Asdf update done!'
}

live_server() {
  browser-sync start --server --files '**/*.*' --port ${1}
}

ide() {
  tmux split-window -h -p 50
  tmux split-window -v -p 50
  tmux select-pane -t 0
}
