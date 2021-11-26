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

    " inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
    " inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
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