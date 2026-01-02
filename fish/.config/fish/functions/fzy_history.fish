function fzy_history
    set -l currbuff (commandline)
    history | fzy --query=$currbuff | read foo

    if [ $foo ]
        commandline -r ''
        commandline -f repaint
        commandline $foo
    else
        commandline ''
        commandline -f repaint
    end
end
