#  Export env variable
export EDITOR=nvim
export KEYTIMEOUT=1
export TERM=screen-256color

# DEFAULT EVIROMENT
export XDG_CONFIG_HOME=$HOME/.config
export ANDROID_HOME=$HOME/Android/Sdk
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
export FZF_ALT_C_COMMAND="fd . $HOME --type d -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# ibus
export GTK_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT4_IM_MODULE=ibus
export CLUTTER_IM_MODULE=ibus
export GLFW_IM_MODULE=ibus

# Alias
alias pwdcp='pwd | xclip -selection clipboard'
alias reload_zsh=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Utils
exit() {
  echo 'Use <C-d> instead!'
}

update_sys() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
}

update_asdf() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim rust
  asdf reshim golang
  asdf reshim java
  asdf reshim ruby
  echo 'Asdf update done!'
}

live_server() {
  browser-sync start --server --files '**/*.*' --port ${1}
}
