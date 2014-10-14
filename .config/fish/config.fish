set -g -x fish_greeting 'i am a [f]r[i]endly [sh]ell'

# Colors
# i have no idea how this works but it does
set default (tput sgr0)
set red (tput setaf 1)
set green (tput setaf 2)
set purple (tput setaf 5)
set orange (tput setaf 9)

# Less colors for man pages
set PAGER less
# Begin blinking
set LESS_TERMCAP_mb $red
# Begin bold
set LESS_TERMCAP_md $orange
# End mode
set LESS_TERMCAP_me $default
# End standout-mode
set LESS_TERMCAP_se $default
# Begin standout-mode - info box
set LESS_TERMCAP_so $purple
# End underline
set LESS_TERMCAP_ue $default
# Begin underline
set LESS_TERMCAP_us $green

# alternatively you can use some vim magic like
# /usr/bin/man std::vector | col -b | vim -R -c 'set ft=man nomod nolist' -
