NEWLINE=$'\n'
PROMPT='%{$fg[green]%}%n@%m:%{$fg[blue]%}%~$(git_prompt_info)%{$reset_color%} ${NEWLINE}$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[cyan]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[cyan]%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
