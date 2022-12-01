function gum_dirs
  z -l | awk '{print $2}' | gum filter --reverse --placeholder="Filter directories..." --indicator="->" --match.foreground 1 --indicator.foreground 1 | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end
