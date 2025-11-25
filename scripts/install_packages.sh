#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DOTFILES_DIR="$(dirname "$SCRIPT_DIR")"

echo "Installing packages from Brewfile..."

# Check if Brewfile exists
if [[ ! -f "$DOTFILES_DIR/Brewfile" ]]; then
    echo -e "${RED}✗ Brewfile not found at $DOTFILES_DIR/Brewfile${NC}"
    exit 1
fi

# Check if brew is installed
if ! command -v brew &> /dev/null; then
    echo -e "${RED}✗ Homebrew is not installed. Please run setup_homebrew.sh first.${NC}"
    exit 1
fi

# Install packages from Brewfile
cd "$DOTFILES_DIR"
echo "Running brew bundle..."
brew bundle --no-lock

echo -e "${GREEN}✓ Packages installed successfully${NC}"
