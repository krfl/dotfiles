#!/bin/bash

echo -e "\n\033[1:31mInstalling Homebrew\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

formulas=(mas git fish starship neovim exa ripgrep bat tldr task tokei rust go node python3 docker gitleaks apktool)
casks=(kitty slack drawio rectangle insomnia visual-studio-code)
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
    echo -e "\n\033[1:31mInstalling font ${var}\033[0m"
    brew install --cask ${var}
done

echo -e "\n\033[1:31mCleaning up existing configurations\033[0m"
rm -rf ~/.config/nvim 2> /dev/null
rm -rf ~/.config/fish/config.fish 2> /dev/null
rm -rf ~/.config/kitty/kitty.conf 2> /dev/null
rm -rf ~/.config/bat/config 2> /dev/null

echo -e "\n\033[1:31mCreating directories\033[0m"
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/kitty
mkdir -p ~/.config/bat

echo -e "\n\033[1:31mInstalling applications from the App Store\033[0m"
mas install 1320666476 1289583905 1147396723 462062816 462058435 985367838 462054704
