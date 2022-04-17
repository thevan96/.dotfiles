#  Export env variable
export EDITOR="nvim"
export KEYTIMEOUT=1
export TERM="screen-256color"

# DEFAULT EVIROMENT
export ZSH="$HOME/.oh-my-zsh"
export ANDROID_HOME=$HOME/Android/Sdk
# export ANDROID_HOME=$HOME/Library/Android/sdk

# ADD PATH
export PATH=$HOME/.local/bin:$PATH
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# FZF
export FZF_DEFAULT_COMMAND="fdfind --type f -i -H -I \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
    "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

zle -N fzf-cd-widget
bindkey '^Y' fzf-cd-widget

# Alias
alias cl="clear"
alias vim="nvim"
alias lg="lazygit"
alias ld="lazydocker"
alias hc="history -c"
alias vimdiff="nvim -d"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias phone="emulator @phone"
alias cpwd="pwd | xclip -selection clipboard"

sys_update() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
}

bs() {
  browser-sync start --server --files --files "**/*.*" --port ${1}
}

asdf_update() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim rust
  asdf reshim golang
  asdf reshim java
  echo 'Asdf update done !'
}

ssh_update() {
  ssh-add ~/.ssh/github_personal
}

ide() {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}
