#!/bin/sh

SCOPE=$(gum choose "appstore" "brew")

case $SCOPE in
  appstore)
    mas outdated
    gum confirm && mas upgrade || echo "Upgrade cancelled"
    ;;
  brew)
    brew update
    gum confirm && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
    ;;
  *)
    echo "Wow! This shouldn't happen"
    ;;
esac
