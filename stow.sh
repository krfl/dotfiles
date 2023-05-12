#!/usr/bin/env bash

stow bat -t ~
stow fish -t ~
stow git -t ~
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
