#!/bin/bash

echo -e "\033[1;31mInstalling python 3\033[0m"
brew install python3

echo -e '\033[1;31mInstalling neovim\033[0m'
brew install neovim

echo -e "\n\033[1;31mInstalling silver searcher\033[0m"
brew install the_silver_searcher

echo -e "\n\033[1;31mInstalling thefuck\033[0m"
brew install thefuck

echo -e "\n\033[1;31mInstalling swiftlint\033[0m"
brew install swiftlint

echo -e "\n\033[1;31mInstalling tree\033[0m"
brew install tree

echo -e "\n\033[1;31mTapping casks\033[0m"
brew tap caskroom/cask

echo -e "\n\033[1;31mInstalling iterm2\033[0m"
brew cask install iterm2

echo -e "\n\033[1;31mInstalling karabiner elements\033[0m"
brew cask install karabiner-elements

echo -e "\n\033[1;31mInstalling postman\033[0m"
brew cask install postman

echo -e "\n\033[1;31mInstalling brave\033[0m"
brew cask install brave-browser

echo -e "\n\033[1;31mInstalling visual studio code\033[0m"
brew cask install visual-studio-code

echo -e "\n\033[1;31mInstalling spotify\033[0m"
brew cask install spotify

echo -e "\n\033[1;31mInstalling slack\033[0m"
brew cask install slack

echo -e "\n\033[1;31mInstalling sublime-merge\033[0m"
brew cask install sublime-merge

echo -e "\n\033[1;31mInstalling 1password\033[0m"
brew cask install 1password

echo -e "\n\033[1;31mInstalling vim-plug\033[0m"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\n\033[1;31mEnabling python support for nvim\033[0m"
pip3 install pynvim

echo -e "\n\033[1;31mInstalling fira code\033[0m"
brew cask install font-fira-code

echo -e "\n\033[1;31mInstalling ia writer mono\033[0m"
brew cask install font-ia-writer-mono

echo -e "\n\033[1;31mInstalling ia writer duo\033[0m"
brew cask install font-ia-writer-duo

echo -e "\n\033[1;31mInstalling ia writer quattro\033[0m"
brew cask install font-ia-writer-quattro


echo -e "\n\033[1;31mInstalling sf mono\033[0m"
cd /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/
cp *.otf ~/Library/Fonts/
cd -

echo -e "\n\033[1;31mCleaning up existing configurations\033[0m"
rm -rf ~/.vim ~/.vimrc ~/.config/nvim ~/.bash_profile 2> /dev/null

echo -e "\n\033[1;31mCreating directories\033[0m"
mkdir -p ~/.config ~/.config/nvim

echo -e "\n\033[1;31mSymlinking configurations\033[0m"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s $DIR/vimrc ~/.config/nvim/init.vim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/bash_profile ~/.bash_profile

