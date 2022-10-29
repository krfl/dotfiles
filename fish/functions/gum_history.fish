function gum_history
  history | gum filter --reverse --indicator="->" | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
