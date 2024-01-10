# markdown preview
function m
    if [ $argv ]
        ls *.md | entr -c glow $argv
    else
        ls *.md | entr -c glow (ls *.md | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:down,tab:up --cycle --keep-right --tabstop=1 --exit-0 --select-1)
    end
end
