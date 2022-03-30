#!/bin/bash

echo -e "\n\033[1:31mInstalling Homebrew\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

tools=(git fish starship neovim task ripgrep rust go node python3 docker)
sugar=(exa bat tldr task tokei gitleaks apktool mas)
casks=(kitty slack drawio rectangle insomnia visual-studio-code)
fonts=(font-jetbrains-mono font-jetbrains-mono-nerd-font font-sf-mono)

for var in "${tools[@]}"
do
    echo -e "\n\033[1:31mInstalling ${var}\033[0m"
    brew install ${var}
done

for var in "${sugar[@]}"
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

echo -e "\n\033[1:31mInstalling applications from the App Store\033[0m"
mas install 1320666476 1289583905 1147396723 462062816 462058435 985367838 462054704
