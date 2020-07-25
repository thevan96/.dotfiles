# Config zsh
alias rl=". ~/.zshrc && echo 'ZSH config reloaded from ~/.zshrc'"

# tmux
alias kwindow="tmux kill-window"
alias ktmux="tmux kill-server"

# Alias tool
alias ex="exit"
alias ff="fg"
alias cl="clear"
alias hc="history -c"
alias fp="sudo lsof -i -P -n"
alias kp="kill-port"
alias cat="bat"
alias top="htop"
alias pwdc="pwd | xclip -selection clipboard "
 
git-search () {
  git log --all --grep="${1}"
}

ua () {
    sudo apt -y update &&
    sudo apt -y upgrade &&
    sudo apt -y autoremove &&
    sudo apt -y autoclean &&
    cd $HOME/.nvm && git pull origin master &&
    cd $HOME/.oh-my-zsh && git pull origin master &&
    cd $HOME/.pyenv && git pull origin master &&
    cd $HOME/.fzf && git pull origin master &&
    cd
}

keep-android () {
  wmctrl -i -r $(wmctrl -l | grep ' Android Emulator - ' |
  sed -e 's/\s.*$//g') -b toggle,above
}

# Set env variable
export KEYTIMEOUT=1
export EDITOR=vi
export TERM="screen-256color"

# Laravel export, composer, php
export PATH="$HOME/.config/composer/vendor/bin:$PATH"

# Pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
if command -v pyenv 1>/dev/null 2>&1; then
  eval "$(pyenv init -)"
fi

# NVM - Node version manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# FZF
export FZF_DEFAULT_COMMAND='fdfind --type f -i -H -I --exclude .git --exclude node_modules --exclude vendor --exclude .idea'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_DEFAULT_OPTS='--no-height'

# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
alias phone429="emulator @phone429"
alias phone529="emulator @phone529"
alias phone528="emulator @phone528"
alias phone629="emulator @phone629"
alias rp="scrcpy --turn-screen-off"

export GTK_IM_MODULE=ibus
export XMODIFIERS=@im=ibus
export QT_IM_MODULE=ibus
ZSH_TMUX_AUTOSTART=true

# Include Z
. /usr/local/bin/z.sh
