#!/bin/bash 

PACKAGES="tmux zsh git curl htop"

# on deb-ish with a gui
if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null && xset &>/dev/null; then
  sudo apt-get remove vim-common vim-runtime vim-gtk vim-gui-common vim-tiny
  sudo apt-get update && sudo apt-get install $PACKAGES vim-nox-py2 vim-gnome
else
  # or just deb-ish
  if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null; then
    sudo apt-get update && sudo apt-get install $PACKAGES vim
    if [ $? -ne 0 ]; then echo "something went wrong"; exit 1; fi
  fi
fi

# on rhel-ish
if type yum 2> /dev/null ; then 
  #cat "http_proxy=http://wwwproxy.sandia.gov:80" >> /etc/yum.conf
  sudo yum install $PACKAGES vim -y 
  if [ $? -ne 0 ]; then echo "something went wrong"; exit 1; fi
fi

# and now if on osx
if [ $(uname -s) = "Darwin" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew install $PACKAGES vim
  if [ $? -ne 0 ]; then echo "something went wrong"; exit 1; fi
fi

# give me oh-my-zsh
source zsh-install.sh
main

# move everything home that isn't our git repo
NOT_NEEDED=`ls`
mv .git /tmp/.dont-hurt-me; cp -Rf . $HOME/; mv /tmp/.dont-hurt-me ./.git
for i in $NOT_NEEDED; do rm $HOME/$i; done

# other plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

printf "${BOLD}"
echo  'some extras:                                         '
echo  ' - mim +BundleInstall                                '
echo  ' - get yer .homebrew-github-api-token                '
echo  ' - cd ~/.vimr/bhudle/YouCompleteMe && ./instahh.sh --clang-compiler'
echo  ' if this script breaks please add in changes...      '
echo  ' otherwise you know exactly what happens...          '
printf "${NORMAL}"

env zsh
