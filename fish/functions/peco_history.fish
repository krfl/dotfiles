function peco_history
  history | peco --prompt=" >" | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
