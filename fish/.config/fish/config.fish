fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /sbin
fish_add_path /Applications/Keybase.app/Contents/SharedSupport/bin
fish_add_path /Library/Apple/usr/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/opt/openjdk/bin
fish_add_path ~/.maestro/bin
fish_add_path ~/go/bin
fish_add_path ~/Library/Application\ Support/JetBrains/Toolbox/scripts

set -x HELIX_RUNTIME ~/github.com/helix/runtime
set -x XDG_CONFIG_HOME ~/.config

# Greeting
function fish_greeting
    # __calendar
    # echo ""
end

function find_ds
    command find . -name '*.DS_Store' -print
end

# bind functions to keys
# bind \co peco_zoxide
# bind \cr peco_history
bind \co fzf_zoxide
bind \cr fzf_history

# # Auto envs
# function autovenv --on-variable PWD
#     if test -d $PWD/.venv
#         source .venv/bin/activate.fish &
#     end
# end

# function autoenv --on-variable PWD
#     if test -d $PWD/.env
#         source $PWD/.env
#     end
# end

# Env
export LC_CTYPE="en_US.UTF-8"
export PYTHONDONTWRITEBYTECODE=1
export LS_COLORS="Gxfxcxdxbxegedabagacad"
export CLICOLOR=1

# Editor
export EDITOR="hx"

# Fuck
thefuck --alias | source

# Zoxide
zoxide init fish | source

# Pew pew!
starship init fish | source
