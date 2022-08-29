#!/bin/bash

echo -e "\n\033[1:31mInstalling Homebrew\033[0m"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

echo -e "\n\033[1:31mAdding Homebrew to default shellenv\033[0m"
echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
eval "$(/opt/homebrew/bin/brew shellenv)"

tools=(git starship elvish peco task ripgrep rustup go node python3 docker carapace)
sugar=(exa bat tldr task tokei gitleaks apktool mas imagemagick lazygit)
casks=(kitty slack drawio rectangle)
fonts=(font-caskaydia-cove-nerd-font font-jetbrains-mono-nerd-font)

brew tap homebrew/cask-fonts

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

for var in "${fonts[@]}"
do
    echo -e "\n\033[1:31mInstalling font ${var}\033[0m"
    brew install --cask ${var}
done

echo -e "\n\033[1:31mInstalling applications from the App Store\033[0m"
mas install 1320666476 1289583905 1147396723 462062816 462058435 985367838 462054704

echo -e "\n\033[1:31mSetting DNS to Warp Speed\033[0m"
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001
