# markdown brain
# lets me easily find the markdown document I'm looking for through peco's filtering. 
function mdb
    fd . "$(pwd)" -E Library --extension md | peco --prompt=" >" | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end
