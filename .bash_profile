# Get the aliases and functions
if [ -f ~/.bashrc ]; then
  source ~/.bashrc
fi

# Bash config variable
HISTSIZE=10000
HISTFILESIZE=10000
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# Export env variable
export EDITOR=vim
export KEYTIMEOUT=1
export TERM=screen-256color
export NIXPKGS_ALLOW_UNFREE=1
export NIXPKGS_ALLOW_INSECURE=1
# export MANPAGER="vim +Man!"
export MANPAGER="vim +MANPAGER --not-a-term -"

# DEFAULT EVIROMENT
export XDG_CONFIG_HOME=$HOME/.config
export ANDROID_HOME=$HOME/Android/Sdk
# macos export ANDROID_HOME=$HOME/Library/Android/sdk

# ADD PATH
export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.npm-packages/bin
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

# FZF
export FZF_DEFAULT_COMMAND="scrfindfile"
export FZF_ALT_C_COMMAND="scrfindfolder"
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="-m --bind ctrl-a:toggle-all --height 99%"

# Alias, utils
alias ls='ls -F'
