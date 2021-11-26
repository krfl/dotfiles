echo -e "\n\033[1:31mSymlinking configurations\033[0m"

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# vim
ln -s $DIR/vim/vimrc ~/.vimrc
ln -s $DIR/vim/colorscheme.vim ~/.vim/colorscheme.vim
ln -s $DIR/vim/keymap.vim ~/.vim/keymap.vim
ln -s $DIR/vim/lsp.vim ~/.vim/lsp.vim
ln -s $DIR/vim/plugins.vim ~/.vim/plugins.vim
ln -s $DIR/vim/settings.vim ~/.vim/settings.vim

# fish
ln -s $DIR/fish/config.fish ~/.config/fish/config.fish

#kitty
ln -s $DIR/kitty/kitty.conf ~/.config/kitty/kitty.conf
ln -s $DIR/kitty/themes/ ~/.config/kitty/themes

#bat
ln -s $DIR/bat/config ~/.config/bat/config
