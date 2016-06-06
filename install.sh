#/bin/bash -x
PACKAGES= tmux zsh vim git 

if [ $(uname -s) = "Linux" ]; then
  # see if we has x
  if xset q &>/dev/null; then $PACKAGES+= vim-gnome; fi
  sudo apt-get update && sudo apt-get install $PACKAGES
fi

# and now if on osx
if [ $(uname -s) = "Darwin" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew install $PACKAGES
fi

# get & install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

cp .zshrc ~/
cp .vimrc ~/
cp .tmux.conf ~/

# my theme
cp .oh-my-zsh/themes/baconparty.zsh-theme ~/.oh-my-zsh/themes/

# all vim things
cp -R .vim ~/

git clone git://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "extras:\n\tvim +BundleInstall\tget yer github-homebrew-api-key\t\ncd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-compiler"
