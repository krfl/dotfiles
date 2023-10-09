# htop alias
# tree view and sorted by cpu usage
function htop --wraps htop --description 'alias htop=htop --tree --sort-key PERCENT_CPU'
    command htop --tree --sort-key PERCENT_CPU $argv
end
