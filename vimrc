set nocompatible

set encoding=utf8
set backspace=indent,eol,start
set nowrap
    autocmd FileType markdown setlocal wrap
set autoindent
set ruler
set confirm
set ignorecase
set laststatus=2
set smartcase
set smarttab
set nobackup
set cursorline
set clipboard=unnamed
set incsearch
set softtabstop=4
set shiftwidth=4
set expandtab
set wildmenu
set hlsearch
set complete-=i
set wildmode=longest,list
set completeopt=menu,preview

set scrolloff=1
set sidescrolloff=5

set mouse=r
" let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

language en_US

call plug#begin('~/.local/share/nvim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'zchee/deoplete-jedi'
Plug 'sickill/vim-pasta'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'sheerun/vim-polyglot'
Plug 'vim-syntastic/syntastic'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'yuttie/inkstained-vim'
Plug 'yuttie/hydrangea-vim'
Plug 'kamwitsta/flatwhite-vim'
Plug 'noahfrederick/vim-noctu'
"Plug 'pacha/vem-statusline'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/goyo.vim'
call plug#end()

filetype plugin indent on
syntax enable

" Python
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_highlight_all = 1
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd FileType python setlocal completeopt-=preview
" autocmd BufWritePost *.py call Flake8()
let g:syntastic_python_checkers = ['flake8'] " pyflakes', 'pylint', 'pep8'] 

" Jedi
let g:jedi#show_call_signatures = "1"
let g:jedi#use_tabs_not_buffers = 0

" Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" Nerdtree
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeQuitOnOpen = 1

" Syntastic
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_check_on_w = 1

" Deoplete
let g:deoplete#enable_at_startup = 1

" Indentation guide
let g:indentLine_enabled = 0
let g:indentLine_char = "⟩"

" Colors
set t_Co=256
set t_ut=
if has('termguicolors') && (has('mac') || has('win32'))
    set termguicolors
endif

" Lightline
let g:lightline = {'colorscheme': 'hydrangea'}
set background=dark
colorscheme hydrangea
