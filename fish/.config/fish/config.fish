# PATH
fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /sbin
fish_add_path /Library/Apple/usr/bin
fish_add_path ~/.cargo/bin

# Environment variables, abbreviations, and keybindings are loaded from conf.d/
# Functions are lazy-loaded from functions/

# Initialize external tools
zoxide init fish | source
starship init fish | source
