function gum_history
  history | gum filter --reverse --placeholder="Filter history..." --indicator="->" --match.foreground 1 --indicator.foreground 1 --limit=1 | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end
