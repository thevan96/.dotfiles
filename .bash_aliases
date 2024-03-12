#  Export env variable
export EDITOR=vim
export KEYTIMEOUT=1
export TERM=screen-256color
export NIXPKGS_ALLOW_UNFREE=1
export NIXPKGS_ALLOW_INSECURE=1
export MANPAGER="vi -c MANPAGER -"

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
export FZF_DEFAULT_COMMAND="find . -type f \
  -not -path '*/.git/*' \
  -not -path '*/.direnv/*' \
  -not -path '*/node_modules/*' \
  | sed 's|^./||'
"

export FZF_ALT_C_COMMAND="find . -type d \
  \( -path '*/.git/*' \
  -o \
  -path '*/.direnv/*' \
  -o \
  -path '/*node_modules/*' \
  -prune -o -print \
  \) \
  | sed 's|^./||'
"

export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND
export FZF_DEFAULT_OPTS="-m --bind ctrl-a:toggle-all --height 99%"

# Alias, utils
alias ls='ls -F'
alias vim='nvim'
alias vimdiff='nvimdiff'
alias grep='grep -rn --color=always --exclude-dir={.git,node_modules}'
alias cpwd='pwd | xsel -i --clipboard'

findf() {
  find . -type f \
    -not -path "*/.git/*" \
    -not -path "*/.direnv/*" \
    -not -path "*/node_modules/*" \
    | sed "s|^./||" \
    | sort
}

findd() {
  find . -type d \
    \( -path "*/.git/*" \
    -o \
    -path "*/.direnv/*" \
    -o \
    -path "/*node_modules/*" \
    -prune -o -print \
    \) \
    | sed "s|^./||" \
    | sort
}
