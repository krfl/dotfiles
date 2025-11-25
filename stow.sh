#!/usr/bin/env bash

set -e

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

if ! command -v stow &> /dev/null; then
    echo "Error: stow is not installed"
    echo "Install it with: brew install stow"
    exit 1
fi

# Get the directory where this script is located
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "$SCRIPT_DIR"

echo -e "${BLUE}Stowing dotfiles...${NC}"

# Automatically discover and stow all package directories
# Excludes: hidden directories (.), scripts/, and files
stowed_count=0
skipped_count=0

for dir in */; do
    # Remove trailing slash
    package="${dir%/}"

    # Skip the scripts directory and any other non-config directories
    if [[ "$package" == "scripts" ]]; then
        continue
    fi

    # Check if package is already stowed by looking for existing symlinks
    # This is a simple check - stow will handle edge cases
    already_stowed=false
    has_stowable_content=false

    # Check common locations: direct files in ~ or files in ~/.config/
    if [[ -d "$package/.config" ]]; then
        # Check if any config dirs/files are already symlinked correctly
        for config_item in "$package/.config"/*; do
            [[ ! -e "$config_item" ]] && continue
            has_stowable_content=true

            config_name=$(basename "$config_item")
            target="$HOME/.config/$config_name"

            # Check if target exists and is a symlink pointing to our dotfiles
            if [[ -L "$target" ]] && [[ "$(readlink "$target")" == *"dotfiles/$package/.config/$config_name"* ]]; then
                already_stowed=true
                break
            fi

            # If it's a directory, check if files inside are symlinked
            if [[ -d "$config_item" && -d "$target" ]]; then
                for file in "$config_item"/*; do
                    [[ ! -e "$file" ]] && continue
                    filename=$(basename "$file")
                    if [[ -L "$target/$filename" ]] && [[ "$(readlink "$target/$filename")" == *"dotfiles/$package/.config/$config_name/$filename"* ]]; then
                        already_stowed=true
                        break 2
                    fi
                done
            fi
        done
    fi

    # Check for direct dotfiles in home directory
    for dotfile in "$package"/.*; do
        [[ "$dotfile" == "$package/." || "$dotfile" == "$package/.." ]] && continue
        [[ ! -e "$dotfile" ]] && continue
        has_stowable_content=true

        dotfile_name=$(basename "$dotfile")
        if [[ -L "$HOME/$dotfile_name" ]] && [[ "$(readlink "$HOME/$dotfile_name")" == *"dotfiles/$package/$dotfile_name"* ]]; then
            already_stowed=true
            break
        fi
    done

    # Skip packages with no stowable content (e.g., only .md files)
    if ! $has_stowable_content; then
        continue
    fi

    if $already_stowed; then
        echo "  ✓ $package (already stowed)"
        ((skipped_count++))
    else
        echo -e "  ${GREEN}→${NC} Stowing $package"
        stow "$package" -t ~ 2>&1 || true
        ((stowed_count++))
    fi
done

echo ""
if [[ $stowed_count -eq 0 ]]; then
    echo -e "${GREEN}✓ All dotfiles are up to date! ($skipped_count packages)${NC}"
else
    echo -e "${GREEN}✓ Stowed $stowed_count package(s), skipped $skipped_count${NC}"
fi
