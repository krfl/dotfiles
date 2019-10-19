#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

formulas=(python3 neovim the_silver_searcher thefuck tree mpv tldr tig)
casks=(iterm2 slack spotify drawio)
fonts=(font-fira-code)

brew tap caskroom/cask

for var in "${formulas[@]}"
do
    echo -e "\n\033[1:31mInstalling ${var}\033[0m"
    brew install ${var}
done

for var in "${casks[@]}"
do
    echo -e "\n\033[1:31mInstalling cask ${var}\033[0m"
    brew cask install ${var}
done

for var in "${fonts[@]}"
do
    echo -e "\n\033[1:31mInstalling ${var}\033[0m"
    brew cask install ${var}
done

echo -e "\n\033[1:31mInstalling vim-plug\033[0m"
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\n\033[1:31mEnabling python support for nvim\033[0m"
pip3 install pynvim

echo -e "\n\033[1:31mInstalling SF Mono\033[0m"
cd /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/
cp *.otf ~/Library/Fonts/
cd -

echo -e "\n\033[1:31mCleaning up existing configurations\033[0m"
rm -rf ~/.vim ~/.vimrc ~/.config/nvim ~/.bash_profile 2> /dev/null

echo -e "\n\033[1:31mCreating directories\033[0m"
mkdir -p ~/.config ~/.config/nvim

echo -e "\n\033[1:31mSymlinking configurations\033[0m"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s $DIR/vimrc ~/.config/nvim/init.vim
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/bash_profile ~/.bash_profile
