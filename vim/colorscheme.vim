if has('termguicolors')
  set termguicolors
endif

" if strftime('%H') >= 7 && strftime('%H') < 19
"   set background=light
" else
"   set background=dark
"  endif

let g:lightline = {'colorscheme': 'ghdark'}

set background=dark
colorscheme ghdark

highlight SignifySignAdd    guifg=#3fb950 cterm=NONE gui=NONE
highlight SignifySignDelete guifg=#f85149 cterm=NONE gui=NONE
highlight SignifySignChange guifg=#d29922 cterm=NONE gui=NONE
