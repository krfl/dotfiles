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

# Greeting
function fish_greeting
    cal
end

function cal
    command icalBuddy -f -sc -ss "" -ec "0B859D0F-FDA1-4152-A59E-7AC012E4A433" -eed -eep "notes,attendees" eventsToday
end

function tasks
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed tasksDueBefore:today+1
end

function gotoicloud
    cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/
end

# Functions
function ls
    command exa --sort=type $argv
end

function ll
    command exa --sort=type --long --git --no-icons --no-permissions --no-user --no-time $argv
end

function tree
    command exa --tree $argv
end

function mon
    command top -o cpu -O time $argv
end

function brewup
    command brew update
    command gum confirm --affirmative="Upgrade" --negative="Cancel" --selected.background 2 --selected.foreground 0 && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
end

function page
    cat $argv | gum format -t markdown | gum pager --border-foreground 5
end

function cred
    echo "Turbo-cashew-rocket-913"
    echo "Nectar-cookie-carrot-221"
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

# Fzf
export FZF_DEFAULT_OPTS='--color=border:#cc7c8a --color=fg:#d1d1d1,bg:#181818,hl:#af9cff --color=fg+:#ffffff,bg+:#292929,hl+:#AF9CFF --color=info:#a8cc7c,prompt:#cc7c8a,pointer:#af9cff --color=marker:#87c3ff,spinner:#af9cff,header:#ebc88d'

# Zoxide
zoxide init fish | source

# Pew pew!
starship init fish | source
