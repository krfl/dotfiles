#!/bin/bash

RED="\033[0;31m"
PUR="\033[0;35m"
YLW="\033[1;33m"
NC="\033[0m" # No Color

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# cleanup
echo -e "${PUR}Cleaning up existing configurations${NC}"
rm -rf ~/.config/kitty/ 2> /dev/null
rm -rf ~/.config/bat/ 2> /dev/null
rm -rf ~/.config/helix/ 2> /dev/null
rm -rf ~/.config/peco/ 2> /dev/null
rm -f ~/.config/starship.toml 2> /dev/null
rm -rf ~/.config/fish/ 2> /dev/null
rm -f ~/.zshrc 2> /dev/null

echo -e "${PUR}Creating directories${NC}"
mkdir -p ~/.config/fish
mkdir -p ~/.config/kitty
mkdir -p ~/.config/bat
mkdir -p ~/.config/helix
mkdir -p ~/.config/peco


# ln -s(ymbolic) /path/to/file/or/dir path/to/symlink
echo -e "${PUR}Symlinking configurations${NC}"

# fish
echo -e "${YLW}Fish shell${NC}"
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish
ln -s $DIR/fish/functions ~/.config/fish/functions
ln -s $DIR/fish/conf.d ~/.config/fish/conf.d
ln -s $DIR/fish/scripts ~/.config/fish/scripts
ln -s $DIR/fish/themes ~/.config/fish/themes

# kitty
echo -e "${YLW}Kitty${NC}"
ln -s $DIR/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s $DIR/kitty/themes/ ~/.config/kitty/themes

# bat
echo -e "${YLW}Bat${NC}"
ln -s $DIR/bat/config ~/.config/bat/config

# peco
echo -e "${YLW}Peco${NC}"
ln -s $DIR/peco/config.json ~/.config/peco/config.json
# helix
echo -e "${YLW}Helix${NC}"
ln -s $DIR/helix/config.toml ~/.config/helix/config.toml
ln -s $DIR/helix/themes ~/.config/helix/themes
if [ -d ~/github.com/helix/runtime ]; then
  ln -s ~/github.com/helix/runtime ~/.config/helix/runtime
else
    echo -e "${RED}Helix runtime not detected. Unable to symlink${NC}"
fi

# zsh
echo -e "${YLW}Zsh${NC}"
ln -s $DIR/zsh/zshrc ~/.zshrc

# starship
echo -e "${YLW}Starship${NC}"
ln -s $DIR/starship/starship.toml ~/.config/starship.toml
