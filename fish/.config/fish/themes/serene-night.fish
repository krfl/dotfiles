# Serene Night - Eye-friendly dark theme for Fish shell
# Reduces blue light and eye strain with warm earth tones
# Based on optometry research for computer vision syndrome
#
# To use this theme, add to your ~/.config/fish/config.fish:
#   source /path/to/serene-night.fish

# Syntax Highlighting Colors
set -g fish_color_normal d4cfc4                  # Normal text - soft cream
set -g fish_color_command 9aaa82                 # Commands - warm sage
set -g fish_color_keyword b8956d                 # Keywords - muted tan
set -g fish_color_quote 8fae7a                   # Quoted strings - soft sage
set -g fish_color_redirection d4a574             # Redirections - warm sand
set -g fish_color_end b8956d                     # End keyword - muted tan
set -g fish_color_error b87860                   # Errors - terracotta red
set -g fish_color_param d4cfc4                   # Parameters - soft cream
set -g fish_color_comment a89984                 # Comments - warm stone
set -g fish_color_selection --background=3d3420 # Selection - dark olive background
set -g fish_color_operator d4a574               # Operators - warm sand
set -g fish_color_escape d4a574                  # Escape sequences - warm sand
set -g fish_color_autosuggestion a89984          # Autosuggestions - warm stone
set -g fish_color_cwd 9aaa82                     # Current directory - warm sage
set -g fish_color_user 9aaa82                    # Username - warm sage
set -g fish_color_host 9aaa82                    # Hostname - warm sage
set -g fish_color_host_remote b8956d             # Remote hostname - muted tan
set -g fish_color_cancel b87860                  # Cancel (^C) - terracotta red
set -g fish_color_search_match --background=3d3420 # Search match - dark olive

# Pager Colors (completion menu)
set -g fish_pager_color_progress a89984          # Progress bar - warm stone
set -g fish_pager_color_prefix 9aaa82 --bold    # Matching prefix - warm sage bold
set -g fish_pager_color_completion d4cfc4       # Completion text - soft cream
set -g fish_pager_color_description a89984      # Description - warm stone
set -g fish_pager_color_selected_background --background=3d3420 # Selected item

# Valid path - underline only (no color change)
set -g fish_color_valid_path --underline
