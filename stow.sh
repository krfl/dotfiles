#!/usr/bin/env bash
set -e

# Colors using tput
if [[ -t 1 ]]; then
    GREEN=$(tput setaf 2)
    YELLOW=$(tput setaf 3)
    RESET=$(tput sgr0)
else
    GREEN='' YELLOW='' RESET=''
fi

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed"
    echo "Install it with: brew install stow"
    exit 1
fi

# Get script directory and change to it
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo "${YELLOW}Stowing dotfiles...${RESET}"

# Stow all directories except those in .stow-local-ignore
# The --restow flag handles both new and existing packages
stow --restow --verbose=1 --target="$HOME" */ 2>&1 | grep -E "LINK|UNLINK" | sed 's/^/  /' || true

echo "${GREEN}✓ Done!${RESET}"
