#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if command exists
command_exists() {
    command -v "$1" &> /dev/null
}

echo "Checking Homebrew..."

# Install homebrew if not installed (idempotent)
if command_exists brew; then
    echo -e "${GREEN}✓ Homebrew already installed${NC}"
    BREW_PREFIX=$(brew --prefix)
    echo "  Location: $BREW_PREFIX"
    exit 0
fi

echo -e "${YELLOW}Installing Homebrew...${NC}"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# Add Homebrew to PATH for Apple Silicon Macs
if [[ -f /opt/homebrew/bin/brew ]]; then
    echo "eval \"\$(/opt/homebrew/bin/brew shellenv)\"" >> ~/.zprofile
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Verify installation
if command_exists brew; then
    echo -e "${GREEN}✓ Homebrew installed successfully${NC}"
    BREW_PREFIX=$(brew --prefix)
    echo "  Location: $BREW_PREFIX"
else
    echo -e "${RED}✗ Homebrew installation failed${NC}"
    exit 1
fi
