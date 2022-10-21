function gum_history
  history | gum filter | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
