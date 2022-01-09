echo -e "\n\033[1:31mSymlinking configurations\033[0m"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# neovim
ln -s $DIR/neovim/init.lua ~/.config/nvim/init.lua
ln -s $DIR/neovim/lua ~/.config/nvim/lua

# fish
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish
ln -s $DIR/fish/themes ~/.config/fish/themes

# kitty
ln -s $DIR/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s $DIR/kitty/themes/ ~/.config/kitty/themes

# bat
ln -s $DIR/bat/config ~/.config/bat/config
