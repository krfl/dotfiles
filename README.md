# dotfiles

Clean, minimal dotfiles meant for macOS using GNU Stow and Homebrew.

## Installation

```bash
git clone https://github.com/krfl/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

This will:
1. Install Homebrew (includes Xcode Command Line Tools)
2. Install packages from Brewfile
3. Symlink dotfiles using GNU Stow
4. Optionally apply macOS settings

## What's Configured

- **Shell**: Fish (with custom functions)
- **Terminal**: WezTerm
- **Editors**: Helix, Zed
- **Tools**: Ripgrep, Eza, Zoxide, Starship, and more
- **Themes**: System-aware dark/light mode switching of [serene themes](https://github.com/krfl/serene-theme/)

## Updating

```bash
# Update packages
brew bundle --file=~/.dotfiles/Brewfile

# Re-sync dotfiles (after adding new configs)
~/.dotfiles/stow.sh
```

## Adding New Dotfiles

```bash
# Move your config into the dotfiles structure
mkdir -p ~/.dotfiles/myapp/.config/myapp
mv ~/.config/myapp/config.yaml ~/.dotfiles/myapp/.config/myapp/

# Re-stow to create symlinks
~/.dotfiles/stow.sh
```

That's it! Stow automatically discovers new packages.

## Notes

- All scripts are idempotent (safe to re-run)
- `.stow-local-ignore` excludes non-config files from symlinking
