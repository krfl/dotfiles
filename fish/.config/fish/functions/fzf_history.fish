# peco history
# feeds history into peco for filtering and a better reverse search
function fzf_history
    history | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:down,tab:up --cycle --keep-right --tabstop=1 --exit-0 --select-1 | read foo
    if [ $foo ]
        commandline -r ''
        commandline -f repaint
        commandline $foo
    else
        commandline ''
        commandline -f repaint
    end
end
