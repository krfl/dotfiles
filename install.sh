#!/usr/bin/env bash

sudo xcodebuild -license # agree with license
xcode-select --install # Install command line tool

if [[ $(command -v brew) == "" ]]; then
    echo 'Homebrew not found'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval "$(/opt/homebrew/bin/brew shellenv)"" >> ~/.zprofile
    exit 0
fi

brew bundle

stow bat -t ~
stow fish -t ~
stow helix -t ~
if [ -d ~/github.com/helix/runtime ]; then
  ln -s ~/github.com/helix/runtime ~/.config/helix/runtime
else
    echo 'Helix runtime not detected. Unable to symlink'
fi
stow htop -t ~
stow kitty -t ~
stow peco -t ~
stow starship -t ~
stow zed -t ~
stow zsh -t ~
