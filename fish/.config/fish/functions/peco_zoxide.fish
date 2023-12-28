# peco zoxide
# feeds zoxide directories into peco for filtering 
function peco_zoxide
    zoxide query -ls | awk '{print $2}' | peco --prompt=' >' | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
    end
end
