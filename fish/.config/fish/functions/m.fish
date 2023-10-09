# markdown preview
function m
    if [ $argv ]
        ls *.md | entr -c glow $argv
    else
        ls *.md | entr -c glow (ls *.md | peco)
    end
end
