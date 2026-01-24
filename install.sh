#!/usr/bin/env bash
set -e

# Colors using tput (portable and readable)
if [[ -t 1 ]]; then
    RED=$(tput setaf 1)
    GREEN=$(tput setaf 2)
    BLUE=$(tput setaf 4)
    YELLOW=$(tput setaf 3)
    RESET=$(tput sgr0)
else
    RED='' GREEN='' BLUE='' YELLOW='' RESET=''
fi

DOTFILES_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo -e "${BLUE}Installing dotfiles...${RESET}\n"

# 1. Install Homebrew (includes Xcode CLI tools)
if ! command -v brew &> /dev/null; then
    echo -e "${YELLOW}→ Installing Homebrew...${RESET}"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

    # Add to PATH for Apple Silicon
    [[ -f /opt/homebrew/bin/brew ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
else
    echo -e "${GREEN}✓ Homebrew already installed${RESET}"
fi

# 2. Install packages
echo -e "\n${YELLOW}→ Installing packages...${RESET}"
brew bundle --file="$DOTFILES_DIR/Brewfile"

# 3. Symlink dotfiles
echo -e "\n${YELLOW}→ Symlinking dotfiles...${RESET}"
"$DOTFILES_DIR/stow.sh"

# 4. macOS settings (optional)
echo -e "\n${YELLOW}→ Apply macOS settings? (y/N)${RESET}"
read -r response
if [[ "$response" =~ ^[Yy]$ ]]; then
    defaults write com.apple.desktopservices DSDontWriteNetworkStores true
    defaults write NSGlobalDomain AppleShowAllExtensions -bool true
    defaults write com.apple.finder ShowPathbar -bool true
    defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock mineffect -string "scale"
    defaults write com.apple.dock tilesize -int 48
    killall Dock
    echo -e "${GREEN}✓ macOS settings applied${RESET}"
fi

echo -e "\n${GREEN}✓ Done! Restart your terminal.${RESET}"
