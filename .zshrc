# linux specific stuff
UNAME_S=`uname -s`
if [ $UNAME_S = "Linux" ]; then
  # Path to your oh-my-zsh installation.
  export ZSH=$HOME/.oh-my-zsh
  export SHELL=/usr/bin/zsh

  # make pretty color
  export TERM=xterm-256color 
  # capslock becomes ctrl
  setxkbmap -layout us -option ctrl:nocaps
fi
# and now if on osx
if [ $UNAME_S = "Darwin" ]; then
  export ZSH=$HOME/.oh-my-zsh
  export SHELL=/usr/local/bin/zsh
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
# DISABLE_AUTO_UPDATE="true"

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

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

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

# homebrew uses git
### this is PRIVATE ###
export HOMEBREW_GITHUB_API_TOKEN=""

# aliases 
alias sl='echo "is spelled ls you drunk bastard"; ls'
alias c='clear; echo "\n"; ls;'
alias vim='vim -O'
alias mim='mvim -v -O'
#alias vimo='vim -o'
#alias vimO='vim -O'
#alias fzf='fzf -m'

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

alias sftp='with-readline sftp'

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

super()
{
  if [ $# -ne 2 ]
  then
    echo -e "\nusage: super command <host-file>"
    echo -e "\twhere <host-file> has one host per line, e.g."
    echo -e "\t pi@192.168.1.99"
    echo -e "\t pi@192.168.1.98 ...etc"
    return
  fi

  if [ ! -f $2 ]
  then
    echo -e "\n file does not exist"
    return
  fi

  tmux new-window "$1 $2"
  while read i
  do
    tmux split-window -h "$1 $i"
    tmux select-layout tiled > /dev/null
  done < $2

  tmux select-pane -t 0
  tmux set-window-option synchronize-panes on > /dev/null
}

# here we take over the world
pwn()
{
  if [ $# -ne 1 ]
  then
    echo -e "\nusage: pwn <host-file>"
    echo -e "\twhere <host-file> has one host per line, e.g."
    echo -e "\t pi@192.168.1.99"
    echo -e "\t pi@192.168.1.98 ...etc"
    return
  fi

  if [ ! -f $1 ]
  then
    echo -e "\n file does not exist"
    return
  fi

  tmux new-window "ssh $1"
  while read i
  do
    tmux split-window -h "ssh $i"
    tmux select-layout tiled > /dev/null
  done < $1
  tmux select-pane -t 0
  tmux set-window-option synchronize-panes on > /dev/null
}
    

# more tmux 
alias tmux="TERM=screen-256color-bce tmux"
alias t='tmux'
# give me an index for multiple planes
I=$(echo $TMUX_PANE | sed 's/[^0-9]*//g')

# for mosh
LANG=en_US.UTF-8 

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
