#!/bin/bash

RED="\033[0;31m"
PUR="\033[0;35m"
YLW="\033[1;33m"
NC="\033[0m" # No Color

echo -e "${PUR}Enabling Warp${NC}"
networksetup -setdnsservers Wi-Fi 1.1.1.1 1.0.0.1 2606:4700:4700::1111 2606:4700:4700::1001

echo -e "${PUR}Changing default screenshot file type to jpg${NC}"
defaults write com.apple.screencapture type jpg
