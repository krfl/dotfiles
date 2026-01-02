function fzy_zoxide
    set -l currbuff (commandline)
    zoxide query -la | fzy --query=$currbuff | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
        commandline -f repaint
    end
end
