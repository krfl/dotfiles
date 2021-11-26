let mapleader=" "

nnoremap <C-p> :Files<CR>
nnoremap <leader>f :Files<CR>
nnoremap <leader>g :Rg <CR>
nnoremap <leader>b :Buffers<CR>

map <C-s> :source ~/.vimrc<CR>

nnoremap <C-c> <Esc>

nnoremap <C-h> <C-W>h
nnoremap <C-j> <C-W>j
nnoremap <C-k> <C-W>k
nnoremap <C-l> <C-W>l

nnoremap <S-Down> :resize +2<CR>
nnoremap <S-Up> :resize -2<CR>
nnoremap <S-Right> :vertical resize +2<CR>
nnoremap <S-Left> :vertical resize -2<CR>

nnoremap Q <nop>

vmap < <gv
vmap > >gv

xnoremap <C-k> :move '<-2<CR>gv-gv
xnoremap <C-j> :move '>+1<CR>gv-gv
xnoremap <C-c> <Esc>