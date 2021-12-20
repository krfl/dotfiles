if has('termguicolors')
  set termguicolors
endif

" if strftime('%H') >= 7 && strftime('%H') < 19
"   set background=light
" else
"   set background=dark
"  endif


set background=dark
colorscheme fleetish

" let g:lightline = {'colorscheme': 'fleetish'}

function! SyntaxItem()
  return synIDattr(synID(line("."),col("."),1),"name")
endfunction

let g:lightline = {
      \ 'colorscheme': 'fleetish',
      \ 'active': {
      \   'left': [ [ 'mode', 'paste' ],
      \             [ 'hlgroup', 'readonly', 'filename', 'modified' ] ]
      \ },
      \ 'component_function': {
      \   'hlgroup': 'SyntaxItem'
      \ },
      \ }
