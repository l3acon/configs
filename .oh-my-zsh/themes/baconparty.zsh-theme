# vim:ft=zsh ts=2 sw=2 sts=2                                                                    

set_for_root()
{
  [[ $UID -eq 0 ]] &&  echo -n "%{$fg[yellow]%}"
}

PROMPT='%(?,%{$fg[green]%},%{$fg[red]%}) %% '
# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
RPS1='%{$fg[white]%}%2~$(git_prompt_info) %{$fg[magenta]%}$(set_for_root)%n%{$reset_color%}@%{$fg_bold[blue]%}%m%{$reset_color%}'

ZSH_THEME_GIT_PROMPT_PREFIX=" %{$fg[yellow]%}("
ZSH_THEME_GIT_PROMPT_SUFFIX=")%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} ⚡%{$fg[yellow]%}"
