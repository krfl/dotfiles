#!/usr/bin/env bash

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed"
    exit 1
fi

stow bat -t ~
stow fish -t ~
stow git -t ~
stow helix -t ~
stow htop -t ~
stow rio -t ~
stow starship -t ~
stow wezterm -t ~
stow zsh -t ~

echo "Done!"
