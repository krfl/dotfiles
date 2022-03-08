vim.cmd [[
try
    set background=dark
    colorscheme fleetish
catch /^Vim\%((\a\+)\)\=:E185/
    set background=dark
    colorsheme blue
endtry
]]
