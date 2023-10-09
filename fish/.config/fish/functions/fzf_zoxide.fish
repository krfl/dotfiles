# peco zoxide
# feeds zoxide directories into peco for filtering 
function fzf_zoxide
    zoxide query -ls | awk '{print $2}' | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --border=sharp --height=45% --info=inline --layout=reverse --tabstop=1 --exit-0 --select-1 | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
        commandline -f repaint
    end
end
