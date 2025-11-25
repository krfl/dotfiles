# dotfiles

Automated dotfiles management using GNU Stow and Homebrew.

## Quick Start

Clone and run the unified installer:

```bash
git clone https://github.com/krfl/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

This will:
1. Install Xcode Command Line Tools
2. Install Homebrew
3. Install all packages from Brewfile
4. Symlink all dotfiles using GNU Stow
5. Optionally apply macOS settings

## Scripts

### Main Installer

#### `install.sh` (Recommended)
Unified orchestrator that runs all setup scripts in the correct order. Use this for initial setup or full reinstallation.

### Modular Setup Scripts

All scripts are idempotent and can be run independently:

#### `scripts/setup_xcode.sh`
Install Xcode Command Line Tools. Run this first if you need developer tools.

#### `scripts/setup_homebrew.sh`
Install Homebrew package manager. Automatically sets up PATH for Apple Silicon Macs.

#### `scripts/install_packages.sh`
Install all packages from Brewfile using `brew bundle`. Run this to update installed packages.

#### `stow.sh`
Automatically discover and symlink all dotfiles packages. Run this whenever you add new dotfiles.

#### `scripts/macos_options.sh`
Configure macOS system preferences:
- Disable .DS_Store files on network volumes
- Show file extensions in Finder
- Show path bar in Finder
- Set list view as default in Finder
- Autohide Dock
- Set Dock icon size and minimize effect

## Running Individual Scripts

Each script can be run independently for selective updates:

```bash
# Update Homebrew packages
./scripts/install_packages.sh

# Re-apply dotfile symlinks
./stow.sh

# Apply macOS preferences
./scripts/macos_options.sh
```

## Adding New Dotfiles

1. Create a new directory: `mkdir -p myapp/.config/myapp`
2. Add your config files: `mv ~/.config/myapp/config.yaml myapp/.config/myapp/`
3. Run `./stow.sh` (automatically picks up new packages!)

## Structure

```
dotfiles/
├── install.sh                   # Main orchestrator script
├── stow.sh                      # Auto-discovering stow script
├── Brewfile                     # Homebrew packages
├── scripts/
│   ├── setup_xcode.sh          # Xcode CLI tools installer
│   ├── setup_homebrew.sh       # Homebrew installer
│   ├── install_packages.sh     # Brewfile package installer
│   └── macos_options.sh        # macOS preferences
├── bat/                        # bat config
├── fish/                       # Fish shell config
├── git/                        # Git config
├── helix/                      # Helix editor config
├── zsh/                        # Zsh config
└── ...                         # Add more as needed!
```
