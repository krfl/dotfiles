# Serene Day - Eye-friendly light theme for Fish shell
# Reduces glare and eye strain with warm earth tones
# Based on optometry research for computer vision syndrome
#
# To use this theme, add to your ~/.config/fish/config.fish:
#   source /path/to/serene-day.fish

# Syntax Highlighting Colors
set -g fish_color_normal 3d3a33                  # Normal text - warm dark gray
set -g fish_color_command 5c7554                 # Commands - deep sage
set -g fish_color_keyword 8b6f47                 # Keywords - caramel brown
set -g fish_color_quote 5a7a4a                   # Quoted strings - forest green
set -g fish_color_redirection 9a6c3a             # Redirections - warm bronze
set -g fish_color_end 8b6f47                     # End keyword - caramel brown
set -g fish_color_error 8b4a38                   # Errors - terracotta red
set -g fish_color_param 3d3a33                   # Parameters - warm dark gray
set -g fish_color_comment 857d6d                 # Comments - medium gray
set -g fish_color_selection --background=e3d5b8 # Selection - warm beige background
set -g fish_color_operator 9a6c3a               # Operators - warm bronze
set -g fish_color_escape 9a6c3a                  # Escape sequences - warm bronze
set -g fish_color_autosuggestion 857d6d          # Autosuggestions - medium gray
set -g fish_color_cwd 5c7554                     # Current directory - deep sage
set -g fish_color_user 5c7554                    # Username - deep sage
set -g fish_color_host 5c7554                    # Hostname - deep sage
set -g fish_color_host_remote 8b6f47             # Remote hostname - caramel brown
set -g fish_color_cancel 8b4a38                  # Cancel (^C) - terracotta red
set -g fish_color_search_match --background=e3d5b8 # Search match - warm beige

# Pager Colors (completion menu)
set -g fish_pager_color_progress 857d6d          # Progress bar - medium gray
set -g fish_pager_color_prefix 5c7554 --bold    # Matching prefix - deep sage bold
set -g fish_pager_color_completion 3d3a33       # Completion text - warm dark gray
set -g fish_pager_color_description 857d6d      # Description - medium gray
set -g fish_pager_color_selected_background --background=e3d5b8 # Selected item

# Valid path - underline only (no color change)
set -g fish_color_valid_path --underline
