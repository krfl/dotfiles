#!/bin/bash

RED="\033[0;31m"
PUR="\033[0;35m"
YLW="\033[1;33m"
NC="\033[0m" # No Color

echo -e "${PUR}Running ${YELLOW}brew update${NC}" >&2
brew update

read -p "Run 'brew upgrade'? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${PUR}Running ${YELLOW}brew upgrade${NC}" >&2
    brew upgrade
echo -e "${PUR}Running ${YELLOW}brew cleanup${NC}" >&2
    brew cleanup
echo -e "${PUR}Running ${YELLOW}brew autoremove${NC}" >&2
    brew autoremove
echo -e "${PUR}Running ${YELLOW}brew doctor${NC}" >&2
    brew doctor
fi

echo -e "${PUR}Running ${YELLOW}mas outdated${NC}" >&2
mas outdated

read -p "Run 'mas upgrade'? (y/n) " -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    echo -e "${PUR}Running ${YELLOW}mas upgrade${NC}" >&2
    mas upgrade
fi
