#!/bin/bash

/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

formulas=(git fish starship exa tldr python3 tokei onefetch)
casks=(kitty slack drawio rectangle)
fonts=(font-jetbrains-mono font-jetbrains-mono-nerd-font font-sf-mono)

for var in "${formulas[@]}"
do
    echo -e "\n\033[1:31mInstalling ${var}\033[0m"
    brew install ${var}
done

for var in "${casks[@]}"
do
    echo -e "\n\033[1:31mInstalling cask ${var}\033[0m"
    brew install --cask ${var}
done

brew tap homebrew/cask-fonts
for var in "${fonts[@]}"
do
    echo -e "\n\033[1:31mInstalling ${var}\033[0m"
    brew install --cask ${var}
done

echo -e "\n\033[1:31mCleaning up existing configurations\033[0m"
rm -rf ~/.vim ~/.vimrc 2> /dev/null
rm -rf ~/.config/fish/config.fish 2> /dev/null
rm -rf ~/.config/kitty/kitty.conf 2> /dev/null
rm -rf ~/.config/bat/config 2> /dev/null


echo -e "\n\033[1:31mCreating directories\033[0m"
mkdir -p ~/.vim
mkdir -p ~/.config/fish
mkdir -p ~/.config/kitty
mkdir -p ~/.config/bat

echo -e "\n\033[1:31mInstalling vim-plug\033[0m"
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
