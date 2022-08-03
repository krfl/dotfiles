#!/bin/bash

echo -e "\n\033[1:31mSymlinking configurations\033[0m"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# cleanup
echo -e "\n\033[1:31mCleaning up existing configurations\033[0m"
rm -rf ~/.config/nvim/ 2> /dev/null
rm -rf ~/.config/fish/ 2> /dev/null
rm -rf ~/.config/kitty/ 2> /dev/null
rm -rf ~/.config/bat/ 2> /dev/null
rm -rf ~/.config/peco/ 2> /dev/null
rm -rf ~/.config/helix/ 2> /dev/null
rm -f ~/.zshrc 2> /dev/null
rm -rf ~/.config/elvish 2> /dev/null

echo -e "\n\033[1:31mCreating directories\033[0m"
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.config/kitty
mkdir -p ~/.config/bat
mkdir -p ~/.config/peco
mkdir -p ~/.config/helix
mkdir -p ~/.config/elvish


# ln -s(ymbolic) /path/to/file/or/dir path/to/symlink
# neovim
ln -s $DIR/neovim/init.lua ~/.config/nvim/init.lua
ln -s $DIR/neovim/lua ~/.config/nvim/lua

# fish
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish
ln -s $DIR/fish/functions ~/.config/fish/functions
ln -s $DIR/fish/conf.d ~/.config/fish/conf.d
ln -s $DIR/fish/themes ~/.config/fish/themes

# kitty
ln -s $DIR/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s $DIR/kitty/themes/ ~/.config/kitty/themes

# bat
ln -s $DIR/bat/config ~/.config/bat/config

# peco
ln -s $DIR/peco/config.json ~/.config/peco/config.json

# helix
ln -s $DIR/helix/config.toml ~/.config/helix/config.toml
ln -s $DIR/helix/themes ~/.config/helix/themes

# zsh
ln -s $DIR/zsh/zshrc ~/.zshrc

# elvish
ln -s $DIR/elvish/rc.elv ~/.config/elvish/rc.elv
#ln -s $DIR/elvish/aliases ~/.config/elvish/aliases