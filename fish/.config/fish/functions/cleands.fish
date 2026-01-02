function cleands
    if [ $argv ]
        command find $argv -name '.DS_Store' -exec rm -i {} \;
    else
        command find . -name '.DS_Store' -exec rm -i {} \;
    end
end
