brew remove --force $(brew list --formulae) --ignore-dependencies
brew cleanup
brew remove --cask --force $(brew list --cask)
