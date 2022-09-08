NEWLINE=$'\n'
PROMPT='%{$fg[green]%}%n%{$reset_color%}@%{$fg[cyan]%}%m%{$reset_color%}:%{$fg[yellow]%}%~$(git_prompt_info)%{$reset_color%} ${NEWLINE}$ '

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg_bold[blue]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$fg_bold[blue]%})"
ZSH_THEME_GIT_PROMPT_DIRTY=" %{$fg[red]%}✗"
ZSH_THEME_GIT_PROMPT_CLEAN=" %{$fg[green]%}✔"
