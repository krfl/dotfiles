function peco_dirs
  z -l | tail -r | awk '{print $2}' | peco | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end
