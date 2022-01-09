vim.cmd [[
try
  colorscheme fleetish
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry
]]
