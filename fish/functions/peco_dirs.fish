function peco_dirs
  z -l | awk '{print $2}' | peco --prompt=" >" | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end
