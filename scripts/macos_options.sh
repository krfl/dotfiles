#!/bin/bash

RED="\033[0;31m"
PUR="\033[0;35m"
YLW="\033[1;33m"
NC="\033[0m" # No Color

# warp speed dns
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001

# No more .DS_Store files
defaults write com.apple.desktopservices DSDontWriteNetworkStores true

# show extensions in Finder
defaults write NSGlobalDomain "AppleShowAllExtensions" -bool "true"

# show path bar in Finder
defaults write com.apple.finder "ShowPathbar" -bool "true"

# set finder view style
defaults write com.apple.finder "FXPreferredViewStyle" -string "Nlsv"

# autohide dock
defaults write com.apple.dock "autohide" -bool "true"

# minimize effect
defaults write com.apple.dock "mineffect" -string "scale"

# dock icon size
defaults write com.apple.dock "tilesize" -int "64"

# open app indicators
defaults write com.apple.com show-process-indicators -bool true

# show recents in dock
# defaults write com.apple.dock show-recents -bool true
# defaults write com.apple.dock show-recent-count -int 20

# restart dock
killall Dock
