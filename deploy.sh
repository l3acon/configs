#!/bin/bash

PACKAGES="tmux zsh git curl htop"

# on deb-ish with a gui
if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null && xset &>/dev/null; then
  sudo apt-get update  && \
    sudo apt-get install -s $PACKAGES vim-nox-py2 vim-gnome && \
    sudo apt-get remove -y vim-common vim-runtime vim-gtk vim-gui-common vim-tiny
  sudo apt-get install -y $PACKAGES vim-nox-py2 vim-gnome || exit $?
else
  # or just deb-ish
  if [ $(uname -s) = "Linux" ] && type apt-get 2> /dev/null; then
    sudo apt-get update && sudo apt-get install -y $PACKAGES vim || exit $?
  fi
fi

# on rhel-ish
if type yum 2> /dev/null ; then 
  sudo yum install $PACKAGES vim -y || exit $?
fi

# on arch-ish
if type pacman 2> /dev/null ; then 
  sudo pacman -R vim --noconfirm && sudo pacman -S $PACKAGES gvim --noconfirm || exit $?
fi

# and now if on osx
if [ $(uname -s) = "Darwin" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew install $PACKAGES vim || exit $?
fi

# update and check if we has this repo
git pull
if ! $? ; then
  git clone https://github.com/l3acon/configs.git && cd configs
fi

## install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

prefix=$(pwd)/home                                                              
for file in $(find $prefix -type f); do                                         
  dest=$HOME/"${file#$prefix/}"                                                 
  rm -f $dest                                                                 
  # build directories if needed                                                 
  mkdir -p $(dirname $dest)                                                     
  # link all the things                                                         
  echo "linking $dest -> ./home/${file#$prefix/}"
  ln -s $file $dest                                                             
done 

# other plugins
git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting 
# vundle
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim 

#printf "${BOLD}"
echo  'some extras:                                         '
echo  ' - get yer .homebrew-github-api-token                '
echo  ' - do YCM: python-dev python3-dev cmake rustc cargo build-essential'
echo  ' ~/.vim/bundle/YouCompleteMe/install.py --clang-completer --racer-completer'
echo  " chsh -s $(which zsh)"
#printf "${NORMAL}"

# get vundle plugins
zsh -c "vim --cmd 'let strong=1' +BundleInstall +qall"
env zsh
