#/bin/bash -x
PACKAGES= tmux zsh vim git 

if [ $(uname -s) = "Linux" ]; then
  sudo apt-get install $PACKAGES
fi
# and now if on osx
if [ $(uname -s) = "Darwin" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew install $PACKAGES
fi

# get & install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp .zshrc ~/
cp .vimrc ~/
cp .tmux.conf ~/

# my theme
cp .oh-my-zsh/themes/baconparty.zsh-theme ~/.oh-my-zsh/themes/

cp -R .vim ~/

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
