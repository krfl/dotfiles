#!/usr/bin/env bash

sudo xcodebuild -license # agree with license
xcode-select --install # Install command line tools

if [[ $(command -v brew) == "" ]]; then
    echo 'Homebrew not found'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval "$(/opt/homebrew/bin/brew shellenv)"" >> ~/.zprofile
    exit 0
fi

brew bundle
