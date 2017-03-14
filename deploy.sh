#!/bin/bash 

PACKAGES="tmux zsh git curl htop"

# on deb-ish with a gui
if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null && xset &>/dev/null; then
  sudo apt-get remove -y vim-common vim-runtime vim-gtk vim-gui-common vim-tiny
  sudo apt-get update && sudo apt-get install -y $PACKAGES vim-nox-py2 vim-gnome
else
  # or just deb-ish
  if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null; then
    sudo apt-get update && sudo apt-get install -y $PACKAGES vim
    if [ $? -ne 0 ]; then echo "something went wrong"; exit 1; fi
  fi
fi

# on rhel-ish
if type yum 2> /dev/null ; then 
  #cat "http_proxy=http://wwwproxy.sandia.gov:80" >> /etc/yum.conf
  sudo yum install $PACKAGES vim -y 
  if [ $? -ne 0 ]; then echo "something went wrong"; exit 1; fi
fi

# on arch-ish
if type pacman 2> /dev/null ; then 
  sudo pacman -R vim --noconfirm
  sudo pacman -S $PACKAGES gvim --noconfirm
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
shopt -s extglob
cp -aR !(.git|..|.|zsh-install.sh|deploy.sh) $HOME/

# other plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

printf "${BOLD}"
echo  'some extras:                                         '
echo  ' - get yer .homebrew-github-api-token                '
echo  ' - do YCM: python-dev python3-dev cmake rustc cargo build-essential'
echo  ' ~/.vim/bundle/YouCompleteMe/install.sh --clang-completer --racer-completer'
echo  ' if this script breaks please add in changes...      '
echo  ' otherwise you know exactly what happens...          '
printf "${NORMAL}"

env zsh -c " vim +BundleInstall +q"
