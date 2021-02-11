set nocompatible

" Load plugins
call plug#begin('~/.vim/plugged')
" Startup
Plug 'mhinz/vim-startify'

" File/search/picker
Plug 'lotabout/skim', { 'dir': '~/.skim', 'do': './install' }
Plug 'lotabout/skim.vim'

" Git
Plug 'mhinz/vim-signify'

" Goldfish mode
Plug 'liuchengxu/vim-which-key', { 'on': ['WhichKey', 'WhichKey!'] }

" Syntax and completion
Plug 'sheerun/vim-polyglot'
Plug 'sickill/vim-pasta'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'
Plug 'prabirshrestha/asyncomplete-buffer.vim'
Plug 'prabirshrestha/asyncomplete-file.vim'

" Color schemes
Plug 'itchyny/lightline.vim'
Plug 'tyrannicaltoucan/vim-deep-space'
call plug#end()

" force utf-8 by default
set encoding=utf8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup
set noswapfile

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=1000
" set timeoutlen=500

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Make backspace work
set backspace=indent,eol,start

" No wrapping
set nowrap
  autocmd FileType markdown setlocal wrap

" Prevent bad stuff
set confirm

" Clipboard convenience
set clipboard+=unnamed,unnamedplus

" Code-style convenience
set autoindent
set softtabstop=4
set shiftwidth=4
set smarttab
set expandtab
set showmatch

" Search convenience
set ignorecase
set smartcase
set incsearch
set hlsearch

" Location convenience
set cursorline
set path+=**

" Statusline
set laststatus=2

" Completion convenience
set wildmenu
set wildmode=longest,list
set complete-=i
set completeopt=menuone,noinsert,noselect
set wildignore+=*.git                                       " git files
set wildignore+=*cache,*.user,*.autosave,build*             " cache and editor files
set wildignore+=*.dll,*.exe,*.dylib,*.app,*.o,*.obj,*.so    " compiled binary files/bundles
set wildignore+=*.png,*.jpeg,*.jpg,*.dds                    " image files
set wildignore+=.DS_Store                                   " macOS DirectoryServices files

" Scrolling convenience
set scrolloff=2
set sidescrolloff=5

" English, always
language en_US

" Plugins
" Install vim-plug if not found
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
endif

" Run PlugInstall if there are missing plugins
autocmd VimEnter * if len(filter(values(g:plugs), '!isdirectory(v:val.dir)'))
  \| PlugInstall --sync | source $MYVIMRC
\| endif


filetype plugin indent on
syntax enable

" LSP
function! s:on_lsp_buffer_enabled() abort
    setlocal omnifunc=lsp#complete
    setlocal signcolumn=yes
    if exists('+tagfunc') | setlocal tagfunc=lsp#tagfunc | endif
    nnoremap <buffer> <leader>ld :LspDefinition<cr>
    nnoremap <buffer> <leader>lr :LspReferences<cr>
    nnoremap <buffer> <leader>li :LspImplementation<cr>
    nnoremap <buffer> <leader>lt :LspTypeDefinition<cr>
    nnoremap <buffer> <leader>ln :LspRename<cr>
    nnoremap <buffer> <leader>lh :LspHover<cr>
    nnoremap <buffer> <leader>le :LspDocumentDiagnostic<cr>
    nnoremap <buffer> <leader>lf :LspDocumentFormat<cr>
    nnoremap <buffer> <leader>lc :LspCodeAction<cr>

    inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
    inoremap <expr> <cr>    pumvisible() ? asyncomplete#close_popup() : "\<cr>"
    
    imap <c-space> <Plug>(asyncomplete_force_refresh)

    let g:lsp_format_sync_timeout = 1000
    autocmd! BufWritePre * call execute('LspDocumentFormatSync')
    
    call asyncomplete#register_source(asyncomplete#sources#buffer#get_source_options({
    \ 'name': 'buffer',
    \ 'allowlist': ['*'],
    \ 'blocklist': ['go'],
    \ 'completor': function('asyncomplete#sources#buffer#completor'),
    \ }))
    
    au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#file#get_source_options({
    \ 'name': 'file',
    \ 'allowlist': ['*'],
    \ 'priority': 10,
    \ 'completor': function('asyncomplete#sources#file#completor')
    \ }))
endfunction

augroup lsp_install
    au!
    " call s:on_lsp_buffer_enabled only for languages that has the server registered.
    autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

let g:lsp_diagnostics_signs_error = {'text': '█'}
let g:lsp_diagnostics_signs_warning = {'text': '▓'}
let g:lsp_diagnostics_signs_information = {'text' : '▒'}
let g:lsp_diagnostics_signs_hint = {'text': '░'}

" Netrw
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3

" Signify
let g:signify_sign_add               = '▌'
let g:signify_sign_delete            = '▌'
let g:signify_sign_delete_first_line = '▌'
let g:signify_sign_change            = '▌'
let g:signify_sign_change_delete     = g:signify_sign_change . g:signify_sign_delete_first_line
let g:signify_priority               = 5

" Fzf
let g:fzf_preview_window = 'right:65%'
let g:fzf_layout = {'up':'40%'}
let g:fzf_buffers_jump = 1
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
let $FZF_DEFAULT_OPTS = '--reverse'

" Key remaps
let mapleader=" "
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

nnoremap <leader>f :Files .<CR>
nnoremap <leader>r :Rg .<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <C-p> :Files .<CR>


vmap < <gv
vmap > >gv

xnoremap <C-k> :move '<-2<CR>gv-gv
xnoremap <C-j> :move '>+1<CR>gv-gv
xnoremap <C-c> <Esc>

" Goldfish mode
nnoremap <silent> <leader> :WhichKey '<Space>'<CR>

" Lightline
let g:lightline = {'colorscheme': 'deepspace' }

" Colors
set background=dark
set termguicolors
colorscheme deep-space
