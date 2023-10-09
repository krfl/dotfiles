# peco history
# feeds history into peco for filtering and a better reverse search
function peco_history
    history | peco --prompt=" >" | read foo
    if [ $foo ]
        commandline $foo
    else
        commandline ''
    end
end
