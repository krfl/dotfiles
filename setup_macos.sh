#!/usr/bin/env bash

# agree with license and install xcode command line tools
sudo xcodebuild -license
xcode-select --install

# install homebrew if not installed
if [[ $(command -v brew) == "" ]]; then
    echo 'Homebrew not found'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval "$(/opt/homebrew/bin/brew shellenv)"" >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# install brew bundle
brew bundle
