#!/bin/bash

RED='\033[0;31m'
PUR='\033[0;35m'
YLW='\033[1;33m'
NC='\033[0m' # No Color

if ! [ -x "$(brew -v git)" ]; then
    echo -e '{RED}Homebrew not found{NC}' >&2
    echo -e '{PUR}Installing {YELLOW}Homebrew{NC}' >&2
    /bin/bash -c '$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)'

    echo -e '{PUR}Adding {YELLOW}Homebrew{PUR} to default shellenv{NC}'
    echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
fi

formulas=(git starship z peco task ripgrep rustup node python3 carapace tokei exa bat tldr gitleaks imagemagick)
casks=(kitty slack drawio rectangle docker raycast font-jetbrains-mono-nerd-font)

brew tap homebrew/cask-fonts

for var in "${formulas[@]}"
do
    echo -e "{PUR}Installing {YLW}${var}{NC}"
    brew install ${var}
done

for var in "${casks[@]}"
do
    echo -e "{PUR}Installing cask {YLW}${var}{NC}"
    brew install --cask ${var}
done
