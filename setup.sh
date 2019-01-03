#!/bin/bash

# Install required software
brew install neovim python3 ag
brew tap caskroom/cask
brew cask install iterm2

# Enable nvim plugin and python support
curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
pip3 install neovim

# Install fonts
brew tap caskroom/fonts
brew cask install font-fira-code

# Remove any existing configurations
rm -rf ~/.vim ~/.vimrc ~/.config/nvim ~/.bash_profile 2> /dev/null

# Create required directories
mkdir -p ~/.config ~/.config/nvim

# Link configurations
ln -s ~/dotfiles/vimrc ~/.config/nvim/init.vim
ln -s ~/dotfiles/vimrc ~/.vimrc
ln -s ~/dotfiles/bash_profile ~/.bash_profile

