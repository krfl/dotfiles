vim.cmd [[
try
    set background=dark
    colorscheme fleetish
catch /^Vim\%((\a\+)\)\=:E185/
    " make it obvious something is wrong
    set background=dark
    colorsheme blue
endtry
]]
