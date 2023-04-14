function peco_zoxide
  zoxide query -ls | awk '{print $2}' | peco --prompt=" >" | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end

function peco_history
  history | peco --prompt=" >" | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
