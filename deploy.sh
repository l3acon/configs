#!/bin/bash

PACKAGES="tmux zsh git curl htop"

## on deb-ish with a gui
#if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null && xset &>/dev/null; then
#  sudo apt-get update  && \
#    sudo apt-get install -s $PACKAGES vim-nox-py2 vim-gnome && \
#    sudo apt-get remove -y vim-common vim-runtime vim-gtk vim-gui-common vim-tiny
#  sudo apt-get install -y $PACKAGES vim-nox-py2 vim-gnome || exit $?
#else
#  # or just deb-ish
#  if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null; then
#    sudo apt-get update && sudo apt-get install -y $PACKAGES vim || exit $?
#  fi
#fi
#
## on rhel-ish
#if type yum 2> /dev/null ; then 
#  sudo yum install $PACKAGES vim -y || exit $?
#fi
#
## on arch-ish
#if type pacman 2> /dev/null ; then 
#  sudo pacman -R vim --noconfirm && sudo pacman -S $PACKAGES gvim --noconfirm || exit $?
#fi
#
## and now if on osx
#if [ $(uname -s) = "Darwin" ]; then
#  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
#  brew update && brew install $PACKAGES vim || exit $?
#fi

# update and check if we has this repo
git pull || git clone https://github.com/l3acon/configs.git && cd configs || exit $?

# give me oh-my-zsh
source zsh-install.bash
main

# move everything home that isn't our git repo
shopt -s extglob
cp -aR !(.git|..|.|zsh-install.bash|deploy.sh) $HOME/

# other plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 

printf "${BOLD}"
echo  'some extras:                                         '
echo  ' - get yer .homebrew-github-api-token                '
echo  ' - do YCM: python-dev python3-dev cmake rustc cargo build-essential'
echo  ' ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --racer-completer'
echo  ' if this script breaks please add in changes...      '
echo  ' otherwise you know exactly what happens...          '
printf "${NORMAL}"

# get vundle plugins
env zsh -c " vim +BundleInstall +qall"
