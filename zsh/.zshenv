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
export FZF_DEFAULT_COMMAND="fdfind --type f --type d -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Alias
alias cl="clear"
alias vim="nvim"
alias fd="fdfind"
alias nnn="NNN_TRASH=1 nnn -eoH"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias phone="emulator @phone"
alias cp_pwd="pwd | xclip -selection clipboard"

poo() {
  echo 'Pomodoro starting ...' \
  && sleep 1500 \
  && notify-send -u critical 'Notify' 'Pomodoro 25 minutes' \
  && echo 'Pomodoro end'
}

pss() {
  echo 'Short break starting ...' \
  && sleep 300 \
  && notify-send -u critical 'Notify' 'Short break 5 minutes' \
  && echo 'Short break end'
}

pll() {
  echo 'Long break starting ...' \
  && sleep 600 \
  && notify-send -u critical 'Notify' 'Long break 10 minutes' \
  && echo 'Long break end'
}

mkdir_cd() {
  mkdir $1 && cd $_
}

sys_update() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
}

bs() {
  browser-sync start --server --files "**/*.*" --port ${1}
}

asdf_update() {
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
