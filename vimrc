set nocompatible
filetype off

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
"set conceallevel=1
set wildmenu
set hlsearch
set complete-=i
set wildmode=longest,list
set completeopt=menu,preview

set scrolloff=1
set sidescrolloff=5

set mouse=r
let $NVIM_TUI_ENABLE_CURSOR_SHAPE=1

language en_US

" nnoremap <Left> :vertical resize -1<CR>
" nnoremap <Right> :vertical resize +1<CR>
" nnoremap <Up> :resize -1<CR>
" nnoremap <Down> :resize +1<CR>
" " Disable arrow keys completely in Insert Mode
" imap <up> <nop>
" imap <down> <nop>
" imap <left> <nop>
" imap <right> <nop>

call plug#begin('~/.local/share/nvim/plugged')
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif
Plug 'nvie/vim-flake8'
Plug 'zchee/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'Yggdroot/indentLine'
Plug 'sickill/vim-pasta'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'ervandew/supertab'
Plug 'vim-syntastic/syntastic'
Plug 'keith/swift.vim'
Plug 'TheCodedSelf/syntastic-swift'
Plug 'itchyny/lightline.vim'
Plug 'yuttie/inkstained-vim'
Plug 'yuttie/hydrangea-vim'
Plug 'kamwitsta/flatwhite-vim'
call plug#end()

filetype plugin indent on

" === Python
let g:python2_host_prog = '/usr/local/bin/python'
let g:python3_host_prog = '/usr/local/bin/python3'
let g:python_highlight_all = 1
autocmd BufRead,BufNewFile *.py let python_highlight_all=1
autocmd FileType python setlocal completeopt-=preview
autocmd BufWritePost *.py call Flake8()

" === Jedi
let g:jedi#show_call_signatures = "1"
let g:jedi#use_tabs_not_buffers = 1

" === Supertab
let g:SuperTabDefaultCompletionType = "<c-n>"

" === Syntastic
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0
let g:syntastic_swift_swiftlint_use_defaults = 1 

" === Swift
let g:syntastic_swift_checkers = ['swiftlint', 'swiftpm'] 

" === Deoplete
let g:deoplete#enable_at_startup = 1

" === Indentation guide
let g:indentLine_enabled = 1
let g:indentLine_char = "⟩"

" === Lightline
let g:lightline = {
      \ 'colorscheme': 'inkstained',
      \ 'component': {
      \   'readonly': '%{&readonly?"":""}',
      \ },
      \ 'separator':    { 'left': '', 'right': '' },
      \ 'subseparator': { 'left': '', 'right': '' },
      \ }

" === Colors
set t_Co=256
set t_ut=
syntax enable

" Linux has termguicolors but it ruins the colors...
if has('termguicolors') && (has('mac') || has('win32'))
    set termguicolors
endif

set background=light
colorscheme inkstained

