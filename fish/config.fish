fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /sbin
fish_add_path /Applications/Keybase.app/Contents/SharedSupport/bin
fish_add_path /Library/Apple/usr/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/opt/openjdk/bin

# Greeting
function fish_greeting
    cal
end

function cal
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed eventsToday+1
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
