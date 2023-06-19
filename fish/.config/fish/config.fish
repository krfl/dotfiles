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

set -x HELIX_RUNTIME ~/github.com/helix/runtime

# Greeting
function fish_greeting
    __theme_mode
    __calendar
    echo ""
end

function __theme_mode
    switch (defaults read -g AppleInterfaceStyle 2>/dev/null)
        case Dark
            sed -i '' "s/theme =.*/theme = 'rose_pine_moon'/" ~/.config/helix/config.toml
            set -Ux FZF_DEFAULT_OPTS "
            	--color=fg:#908caa,bg:#232136,hl:#ea9a97
            	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
            	--color=border:#44415a,header:#3e8fb0,gutter:#232136
            	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
            	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
            command kitty +kitten themes --reload-in=parent Rosé Pine Moon
        case '*'
            sed -i '' "s/theme =.*/theme = 'rose_pine_dawn'/" ~/.config/helix/config.toml
            set -Ux FZF_DEFAULT_OPTS "
            	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
            	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
            	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
            	--color=spinner:#ea9d34,info:#56949f,separator:#dfdad9
            	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
            command kitty +kitten themes --reload-in=parent Rosé Pine Dawn
        end
end

# prints events from calendar
# using icalbuddy and excluding a calendar I don't want to see
function __calendar
    command icalBuddy -f -sc -ss "" -ec "0B859D0F-FDA1-4152-A59E-7AC012E4A433" -eed -eep "notes,attendees" eventsToday
end

# prints tasks from reminders
# using icalbuddy
function __reminders
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed tasksDueBefore:today+1
end

# ls alias using exa
# sorted by type
function ls
    command exa --sort=type $argv
end

# ll alias using exa
# 'short form' ls -l sorted by type
function ll
    command exa --sort=type --long --git --no-icons --no-permissions --no-user --no-time $argv
end

# tree alias using exa
function tree
    command exa --tree $argv
end

# homebrew alias using gum
# updates then optionally  upgrades and cleans up
function brewup
    command brew update
    command gum confirm --affirmative="Upgrade" --negative="Cancel" --selected.background 6 --selected.foreground 0 && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
end

# htop alias
# tree view and sorted by cpu usage
function htop --wraps htop --description 'alias htop=htop --tree --sort-key PERCENT_CPU'
    command htop --tree --sort-key PERCENT_CPU $argv
end

# peco zoxide
# feeds zoxide directories into peco for filtering 
function peco_zoxide
    zoxide query -ls | awk '{print $2}' | peco --prompt=" >" | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
    end
end

# peco history
# feeds history into peco for filtering and a better reverse search
function peco_history
    history | peco --prompt=" >" | read foo
    if [ $foo ]
        commandline $foo
    else
        commandline ''
    end
end

# markdown brain
# lets me easily find the markdown document I'm looking for through peco's filtering. 
function mdb
    fd . '/Users/krfl/' -E Library --extension md | peco --prompt=" >" | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end

# bind functions
bind \co peco_zoxide
bind \cr peco_history

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
