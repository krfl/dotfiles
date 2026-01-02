function mdb
    rg --files --type md --glob '!Library' | fzy | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end
