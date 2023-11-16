#  Export env variable
export EDITOR=vim
export KEYTIMEOUT=1
export TERM=screen-256color

if command -v nvim > /dev/null 2 >&1; then
  export MANPAGER='nvim +Man!'
else
  export LESS_TERMCAP_mb=$'\e[1;31m'
  export LESS_TERMCAP_md=$'\e[1;33m'
  export LESS_TERMCAP_so=$'\e[01;44;37m'
  export LESS_TERMCAP_us=$'\e[01;37m'
  export LESS_TERMCAP_me=$'\e[0m'
  export LESS_TERMCAP_se=$'\e[0m'
  export LESS_TERMCAP_ue=$'\e[0m'
  export MANPAGER="less"
fi

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
export FZF_DEFAULT_COMMAND="fd --type f -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_DEFAULT_OPTS="-m  --bind alt-a:select-all,alt-d:deselect-all"

export FZF_ALT_C_COMMAND="fd --type d -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems \
  "
export FZF_CTRL_T_COMMAND=$FZF_DEFAULT_COMMAND

# Alias, utils
alias vim='nvim'
alias vimdiff='nvimdiff'
alias grep='grep -rn --color=always --exclude-dir={.git,node_modules}'

find_f() {
  find . -type f \
    -not -path "*/.git/*" \
    -not -path "*/.direnv/*" \
    -not -path "*/node_modules/*" \
    | sed "s|^./||" \
    | sort
}

find_d() {
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
