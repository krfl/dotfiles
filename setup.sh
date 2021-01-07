#!/bin/bash

/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

formulas=(python3 thefuck tree mpv tldr vim fish starship)
casks=(kitty slack drawio)
fonts=(font-fira-code font-agave-nerd-font)

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

echo -e "\n\033[1:31mInstalling SF Mono\033[0m"
cd /Applications/Utilities/Terminal.app/Contents/Resources/Fonts/
cp *.otf ~/Library/Fonts/
cd -

echo -e "\n\033[1:31mCleaning up existing configurations\033[0m"
rm -rf ~/.vim ~/.vimrc 2> /dev/null
rm -rf ~/.config/fish/config.fish 2> /dev/null

echo -e "\n\033[1:31mCreating directories\033[0m"
mkdir -p ~/.vim

echo -e "\n\033[1:31mInstalling vim-plug\033[0m"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo -e "\n\033[1:31mSymlinking configurations\033[0m"
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"
ln -s $DIR/vimrc ~/.vimrc
ln -s $DIR/config.fish ~/.config/fish/config.fish
ln -s $DIR/kitty.conf ~/.config/kitty/kitty.conf
