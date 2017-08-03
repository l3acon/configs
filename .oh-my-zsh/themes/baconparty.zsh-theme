# vim:ft=zsh ts=2 sw=2 sts=2                                                                    

# use extended color palette if available
if [[ $terminfo[colors] -ge 256 ]]; then
    orange="%F{3}"
    purple="%F{96}"
    hotpink="%F{161}"
    turquoise="%F{29}"
    bblue="%F{73}"
else
    bblue="%F{cyan}"
    orange="%F{yellow}"
    purple="%F{magenta}"
    hotpink="%F{red}"
    turquoise="%F{green}"
fi

set_for_root()
{
  [[ $UID -eq 0 ]] &&  echo -n "%{$orange%}"
}

PROMPT='%(?,%{$fg[green]%},%{$fg[red]%}) %% '
# RPS1='%{$fg[blue]%}%~%{$reset_color%} '
RPS1='%{$fg[white]%}%2~$(git_prompt_info) %{$purple%}$(set_for_root)%n%{$reset_color%}@%{$hotpink%}%m%{$reset_color%} $(battery_remaining_prompt)'

#ZSH_THEME_GIT_PROMPT_PREFIX=" %{$turquoise%}(%{$bblue%}"
ZSH_THEME_GIT_PROMPT_PREFIX=" %{$turquoise%}%{$bblue%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$turquoise%})"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$turquoise%}"
ZSH_THEME_GIT_PROMPT_CLEAN="%{$purple%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$orange%}☡%{$turquoise%}"
