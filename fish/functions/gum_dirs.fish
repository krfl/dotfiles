function gum_dirs
  z -l | awk '{print $2}' | gum filter | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end
