#!/bin/bash

sudo xcodebuild -license # agree with license
xcode-select --install # Install command line tool

if [[ $(command -v brew) == "" ]]; then
    echo 'Homebrew not found'
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "eval "$(/opt/homebrew/bin/brew shellenv)"" >> ~/.zprofile
    exit 0
fi

brew bundle

# cleanup
rm -rf ~/.config/kitty/ 2> /dev/null
rm -rf ~/.config/bat/ 2> /dev/null
rm -rf ~/.config/helix/ 2> /dev/null
rm -rf ~/.config/peco/ 2> /dev/null
rm -f ~/.config/starship.toml 2> /dev/null
rm -rf ~/.config/fish/ 2> /dev/null
rm -f ~/.zshrc 2> /dev/null

mkdir -p ~/.config/fish
mkdir -p ~/.config/kitty
mkdir -p ~/.config/bat
mkdir -p ~/.config/helix
mkdir -p ~/.config/peco

# ln -s(ymbolic) /path/to/file/or/dir path/to/symlink
# fish
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish
ln -s $DIR/fish/functions ~/.config/fish/functions
ln -s $DIR/fish/conf.d ~/.config/fish/conf.d
ln -s $DIR/fish/scripts ~/.config/fish/scripts
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
if [ -d ~/github.com/helix/runtime ]; then
  ln -s ~/github.com/helix/runtime ~/.config/helix/runtime
else
    echo 'Helix runtime not detected. Unable to symlink'
fi

# zsh
ln -s $DIR/zsh/zshrc ~/.zshrc

# starship
ln -s $DIR/starship/starship.toml ~/.config/starship.toml

