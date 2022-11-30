fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /sbin
fish_add_path /Applications/Keybase.app/Contents/SharedSupport/bin
fish_add_path /Library/Apple/usr/bin
fish_add_path ~/.cargo/bin

# Greeting
function fish_greeting
    # command clear
    # command date +"%d/%m/%Y"
    # command date +"%H:%M:%S"
    # command task next
end

function gotoicloud
    cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/
end

# Functions
function ls
    command exa --sort=type $argv
end

function ll
    command exa --sort=type --long --git --no-icons --no-permissions --no-user --no-time
end

function tree
    command exa --tree $argv
end

function mon
    command top -o cpu -O time $argv
end

function upgradestuff
    command bash ~/github.com/dotfiles/scripts/update_brew_and_app_store.sh
end

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

# Pew pew!
starship init fish | source