#  Export path, env variable
export PATH="$HOME/.local/bin:$PATH"
export ZSH="$HOME/.oh-my-zsh"
export TERM="screen-256color"
export LANG="en_US.UTF-8"
export KEYTIMEOUT=1
export EDITOR=nvim
export RUBYOPT="-W:no-deprecated"

# Ibus config
export GTK_IM_MODULE=ibus
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
export FZF_DEFAULT_COMMAND=" fdfind --type f -i -H -I \
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
alias listSimulator="xcrun simctl list devices"
alias listEmulator="emulator -list-avds"
alias phone5="emulator @phone5"
alias phone56="emulator @phone56"
alias tabletc="emulator @tabletc"

# Alias
alias ..="cd .."
alias ..2="cd ../.."
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"
alias vi="nvim"
alias cl="clear"
alias lg="lazygit"
alias rp="scrcpy --turn-screen-off"
alias glo="git log --oneline --graph"

sys_update() {
  sudo  apt -y update \
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

ii() {
  tmux split-window -v -p 25
  tmux split-window -h -p 50
}

iii() {
  SESSION=${1}
  RUN="run"
  EDITOR="editor"
  GIT="git"
  CONSOLE="console"
  SHELL="shell"
  tmux rename-session $SESSION
  tmux new-window -t $SESSION:2 -n $RUN
  tmux new-window -t $SESSION:3 -n $GIT
  tmux new-window -t $SESSION:4 -n $EDITOR
  tmux new-window -t $SESSION:5 -n $CONSOLE
  tmux new-window -t $SESSION:6 -n $SHELL
  tmux kill-window -t 1
}
