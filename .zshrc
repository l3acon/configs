# linux specific stuff
export ZSH=$HOME/.oh-my-zsh
UNAME_S=`uname -s`
if [ $UNAME_S = "Linux" ]; then
  # Path to your oh-my-zsh installation.
  export SHELL=/usr/bin/zsh
  
  # give me powerful vim
  alias vim='vim -O --cmd "let strong=1"'

  # see if X is running
  if xset q &>/dev/null; then
    # capslock becomes ctrl
    setxkbmap -layout us -option ctrl:nocaps
 fi

  # more pretty colors
  alias ls='ls --color=always'
  alias dmesg='dmesg --color=always'
fi

# and now if on osx
if [ $UNAME_S = "Darwin" ]; then
  export SHELL=/usr/local/bin/zsh
  # pretty colors
  export CLICOLOR_FORCE=1
  # give me macvim
  alias mim='mvim -v -O'
  
  # homebrew uses git
  if [ ! -f $HOME/.homebrew-github-api-token ]
  then
    export HOMEBREW_GITHUB_API_TOKEN=`cat $HOME/.homebrew-github-api-token`
  fi
fi

if which tput >/dev/null 2>&1; then
    ncolors=$(tput colors)
fi
if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
  RED="$(tput setaf 1)"
  GREEN="$(tput setaf 2)"
  YELLOW="$(tput setaf 3)"
  BLUE="$(tput setaf 4)"
  BOLD="$(tput bold)"
  NORMAL="$(tput sgr0)"
else
  RED=""
  GREEN=""
  YELLOW=""
  BLUE=""
  BOLD=""
  NORMAL=""
fi


# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
#ZSH_THEME="random"
#ZSH_THEME="terminalparty"
ZSH_THEME="baconparty"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git battery zsh-syntax-highlighting)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/usr/local/sbin:$PATH"

# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# colors for less?
man() 
{
  env \
  LESS_TERMCAP_mb=$(printf "\e[1;31m") \
  LESS_TERMCAP_md=$(printf "\e[1;31m") \
  LESS_TERMCAP_me=$(printf "\e[0m") \
  LESS_TERMCAP_se=$(printf "\e[0m") \
  LESS_TERMCAP_so=$(printf "\e[1;44;33m") \
  LESS_TERMCAP_ue=$(printf "\e[0m") \
  LESS_TERMCAP_us=$(printf "\e[1;32m") \
  man "$@"
}

# You may need to manually set your language environment
# export LANG=en_US.UTF-8
# yes, for mosh
LANG=en_US.UTF-8 

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"


# aliases 
alias sl='echo "is spelled ls you drunk bastard"; ls'
alias c='clear; echo " "; ls -lah'
# more tmux 
alias tmux="TERM=screen-256color-bce tmux"
alias t='tmux'
#alias fzf='fzf -m'

web() 
{
  links -http-proxy $http_proxy -https-proxy $https_proxy $@
}

# something for opening relevent c files
cim()
{
  THESE=""
  for arg in "$@"
  do
    THESE+=`find . -maxdepth 1 -name "$arg*" -not -name "*.o"`
    if [ -n  "$THESE" ]; then;
      THESE+="\n"; fi
  done
  
  if [ -n  "$THESE" ]
  then
    mim `echo $THESE | tr '\n' ' '`
  fi
}

forever()
{
  if [ $# -lt 1 ] 
  then
    printf "${BOLD}usage: ${NORMAL}forever [speed] <command> [ops...]\n"
    echo -e "\tspeed is optional, the default is one second"
    return
  fi
  if hash "$1" 2>/dev/null
  then
    #watch --differences $@
    while true; do $@ ; sleep 1; done
  else
    #watch --differences --interval $1 ${@:2}
    while true; do ${@:2} ; sleep $1; done
  fi
}

# here we take over the world
pwn() {
  if [ $# -lt 1 ]
  then
    printf "${BOLD}usage: ${NORMAL}pwn [command | (ssh)] ${BOLD}<target-file>${NORMAL}"
    printf "\n\twhere ${BOLD}<target-file>${NORMAL} has one thing per line, e.g."
    printf "\n\t\tpi@192.168.1.99"
    printf "\n\t\tpi@192.168.1.98 ...etc"
    echo -e "\n\tif no command is specified ssh is assumed"
    return
  fi

  PWN_COMMAND=''
  TGT_FILE=''
  if hash "$1" 2>/dev/null
  then
    PWN_COMMAND="$1"
    TGT_FILE="$2"
  else
    # we do ssh by default
    PWN_COMMAND="ssh "
    TGT_FILE="$1"
  fi
  if [ ! -f $TGT_FILE ]
  then
    echo -e "\tfile does not exist"
    return
  fi

  printf "\nwith great power"
  for i in `seq 1 6`; do printf "."; sleep .1; done; echo ""
  tmux new-window "$PWN_COMMAND $$TGT_FILE"
  while read i
  do
    tmux split-window -h "$PWN_COMMAND $i"
    tmux select-layout tiled > /dev/null
  done < $TGT_FILE
  tmux select-pane -t 0
  tmux set-window-option synchronize-panes on > /dev/null
}
    
# give me an index for multiple planes
I=$(echo $TMUX_PANE | sed 's/[^0-9]*//g')


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
