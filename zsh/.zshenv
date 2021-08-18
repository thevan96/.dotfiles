#  Export path, env variable
export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export TERM="screen-256color"
export LANG="en_US.UTF-8"
export KEYTIMEOUT=1
export EDITOR="nvim"
export RUBYOPT="-W:no-deprecated"

# Ibus config
export CLUTTER_IM_MODULE=ibus
export GTK_IM_MODULE=ibus
export QT4_IM_MODULE=ibus
export QT_IM_MODULE=ibus
export XMODIFIERS=@im=ibus

# Android
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# FZF
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_COMMAND="fd --type f -i -H -I \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude tmp \
  "

zle -N fzf-cd-widget
bindkey '^Y' fzf-cd-widget

# Git
alias github="ssh-add $HOME/.ssh/github"
alias gitlab="ssh-add $HOME/.ssh/gitlab"

# Emulator
alias list_simulator="xcrun simctl list devices"
alias list_emulator="emulator -list-avds"
alias phone="emulator @phone"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Alias
alias vi="nvim"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias cl="clear"
alias rp="scrcpy --turn-screen-off"
alias glo="git log --oneline --graph"
alias rails_db="rails db:drop db:create db:migrate db:seed"
alias brubocop="bundle exec rubocop"

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
  asdf reshim ruby
  asdf reshim rust
  echo 'Asdf update done !'
}

ssh_update() {
  ssh-add ~/.ssh/id_rsa_github
}

ide() {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}

rails_ide() {
  SESSION=${1}
  RUN="run"
  EDITOR="editor"
  GIT="git"
  CONSOLE="console"
  tmux rename-session $SESSION
  tmux new-window -t $SESSION:2 -n $RUN
  tmux new-window -t $SESSION:3 -n $EDITOR
  tmux new-window -t $SESSION:4 -n $CONSOLE
  tmux new-window
  tmux kill-window -t 1
}
