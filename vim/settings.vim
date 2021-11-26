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

" Lsp
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