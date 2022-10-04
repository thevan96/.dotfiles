#  Export env variable
export EDITOR=vim
export KEYTIMEOUT=1
export TERM=screen-256color

# DEFAULT EVIROMENT
export ZSH=$HOME/.oh-my-zsh
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
export FZF_DEFAULT_COMMAND="fdfind --type f -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_ALT_C_COMMAND="fdfind . $HOME --type d -H \
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
alias vim='nvim'
alias nnn='NNN_TRASH=2 nnn -deoH'
alias view='nvim -R'
alias lzg='lazygit'
alias lzd='lazydocker'
alias pwdcp='pwd | xclip -selection clipboard'
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# Some more ls aliases
alias ls='ls --color'
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

git_switch() {
  git checkout $(git branch -a | fzf)
}

git_log() {
  watch -c -n1 -t git log --all --decorate --oneline --graph --color
}

git_status() {
  watch -c -n1 -t git status
}

exit() {
  echo 'Use <C-d> instead!'
}

sys_update() {
  sudo apt -y update \
  && sudo apt -y upgrade \
  && sudo apt -y autoclean \
  && sudo apt -y autoremove
}

asdf_update() {
  asdf reshim nodejs
  asdf reshim python
  asdf reshim rust
  asdf reshim golang
  asdf reshim java
  echo 'Asdf update done !'
}

bs() {
  browser-sync start --server --files '**/*.*' --port ${1}
}
