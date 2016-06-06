#/bin/bash -x
PACKAGES= tmux zsh git 

if [ $(uname -s) = "Linux" ]; then
  sudo apt-get remove vim-common vim-runtime vim-gtk vim-gui-common vim-tiny
  sudo apt-get update && sudo apt-get install $PACKAGES vim-nox-py2
fi

# and now if on osx
if [ $(uname -s) = "Darwin" ]; then
  ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
  brew update && brew install $PACKAGES vim
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

echo "extras:\n\tmim +BundleInstall\tget yer github-homebrew-api-key\t\ncd ~/.vim/bundle/YouCompleteMe && ./install.sh --clang-compiler"
