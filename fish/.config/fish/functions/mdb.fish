# markdown brain
# lets me easily find the markdown document I'm looking for through peco's filtering. 
function mdb
    fd . "$(pwd)" -E Library --extension md | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:down,tab:up --cycle --keep-right --tabstop=1 --exit-0 --select-1 | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end
