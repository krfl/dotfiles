vim.cmd [[
try
<<<<<<< Updated upstream
    set background=dark
    colorscheme fleetish
=======
  colorscheme deep-space
>>>>>>> Stashed changes
catch /^Vim\%((\a\+)\)\=:E185/
    set background=dark
    colorsheme blue
endtry
]]
