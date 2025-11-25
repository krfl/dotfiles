#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo "Checking Xcode Command Line Tools..."

# Check if Xcode CLI tools are installed (idempotent)
if xcode-select -p &> /dev/null; then
    echo -e "${GREEN}✓ Xcode Command Line Tools already installed${NC}"
    exit 0
fi

echo -e "${YELLOW}Installing Xcode Command Line Tools...${NC}"
echo "Note: You may need to accept the license agreement"

# Try to accept license first (may require sudo)
if sudo xcodebuild -license accept 2>/dev/null; then
    echo -e "${GREEN}✓ Xcode license accepted${NC}"
fi

# Install command line tools
xcode-select --install 2>/dev/null || true

echo -e "${YELLOW}Waiting for Xcode Command Line Tools installation...${NC}"
echo "Please follow the prompts and press any key when installation is complete"
read -n 1 -s

# Verify installation
if xcode-select -p &> /dev/null; then
    echo -e "${GREEN}✓ Xcode Command Line Tools installed successfully${NC}"
else
    echo -e "${RED}✗ Xcode Command Line Tools installation failed${NC}"
    exit 1
fi
