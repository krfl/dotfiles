#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}================================${NC}"
echo -e "${BLUE}  Dotfiles Installation Script${NC}"
echo -e "${BLUE}================================${NC}"
echo ""

# Function to print section headers
print_section() {
    echo ""
    echo -e "${BLUE}→ $1${NC}"
    echo "-----------------------------------"
}

# Function to run a script and handle errors
run_script() {
    local script_path="$1"
    local script_name=$(basename "$script_path")

    if [[ -x "$script_path" ]]; then
        "$script_path"
    else
        echo -e "${RED}✗ $script_name not found or not executable${NC}"
        exit 1
    fi
}

# ================================
# 1. Install Xcode Command Line Tools
# ================================
print_section "Xcode Command Line Tools"
run_script "$SCRIPT_DIR/scripts/setup_xcode.sh"

# ================================
# 2. Install Homebrew
# ================================
print_section "Homebrew"
run_script "$SCRIPT_DIR/scripts/setup_homebrew.sh"

# ================================
# 3. Install packages from Brewfile
# ================================
print_section "Installing Packages"
run_script "$SCRIPT_DIR/scripts/install_packages.sh"

# ================================
# 4. Stow dotfiles
# ================================
print_section "Setting up dotfiles with GNU Stow"
run_script "$SCRIPT_DIR/stow.sh"

# ================================
# 5. macOS Settings (Optional)
# ================================
print_section "macOS Settings"

if [[ -f "$SCRIPT_DIR/scripts/macos_options.sh" ]]; then
    echo -e "${YELLOW}Apply macOS settings?${NC}"
    echo "This will configure:"
    echo "  - Disable .DS_Store on network volumes"
    echo "  - Show file extensions in Finder"
    echo "  - Show path bar in Finder"
    echo "  - Set list view as default in Finder"
    echo "  - Autohide Dock"
    echo "  - And more..."
    echo ""
    read -p "Apply settings? (y/N): " -n 1 -r
    echo
    if [[ $REPLY =~ ^[Yy]$ ]]; then
        run_script "$SCRIPT_DIR/scripts/macos_options.sh"
        echo -e "${GREEN}✓ macOS settings applied${NC}"
    else
        echo "Skipped macOS settings"
    fi
else
    echo -e "${YELLOW}⚠ macOS settings script not found${NC}"
fi

# ================================
# Done!
# ================================
echo ""
echo -e "${GREEN}================================${NC}"
echo -e "${GREEN}  ✓ Installation Complete!${NC}"
echo -e "${GREEN}================================${NC}"
echo ""
echo "Next steps:"
echo "  1. Restart your terminal to load new configurations"
echo "  2. Run 'fish' to use Fish shell (if installed)"
echo "  3. Check that your dotfiles are properly symlinked:"
echo "     ls -la ~ | grep '\->'"
echo ""
echo "Individual scripts can be re-run anytime:"
echo "  ./scripts/setup_xcode.sh"
echo "  ./scripts/setup_homebrew.sh"
echo "  ./scripts/install_packages.sh"
echo "  ./stow.sh"
echo "  ./scripts/macos_options.sh"
echo ""
