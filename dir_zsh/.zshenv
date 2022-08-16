#  Export env variable
export EDITOR="nvim"
export KEYTIMEOUT=1
export TERM="screen-256color"

# DEFAULT EVIROMENT
export ZSH="$HOME/.oh-my-zsh"
export ANDROID_HOME=$HOME/Android/Sdk
export XDG_CONFIG_HOME="$HOME/.config"
# export ANDROID_HOME=$HOME/Library/Android/sdk

# ADD PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$HOME/.config/lua-language-server/bin:$PATH

# Alias
alias cl="clear"
alias vim="nvim"
alias lzg="lazygit"
alias lzd="lazydocker"
alias tm="tmux"
alias ta="tmux attach"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias phone="emulator @phone"
alias cp_pwd="pwd | xclip -selection clipboard"

# FZF
export FZF_DEFAULT_COMMAND="fdfind . $HOME --type f -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

exit() {
  echo "Use <C-d> instead!"
}

cd_mkdir() {
  mkdir $1 && cd $_
}

notes() {
  cd ~/Workspace/Personal/notes/
  vim .
}

tododiary() {
  cd ~/Workspace/Personal/todo-diary/
  vim .
}

update_sys() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
}

bs() {
  browser-sync start --server --files "**/*.*" --port ${1}
}

update_asdf() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim rust
  asdf reshim golang
  asdf reshim java
  echo 'Asdf update done !'
}

ide() {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}
