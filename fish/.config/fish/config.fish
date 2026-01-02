fish_add_path /opt/homebrew/bin
fish_add_path /opt/homebrew/sbin
fish_add_path /usr/local/bin
fish_add_path /usr/sbin
fish_add_path /sbin
fish_add_path /Library/Apple/usr/bin
fish_add_path ~/.cargo/bin
fish_add_path /opt/homebrew/opt/openjdk/bin

set -x HELIX_RUNTIME ~/github.com/helix/runtime
set -x XDG_CONFIG_HOME ~/.config

# Greeting
function fish_greeting
    # __calendar
    # echo ""
end

# print calendar events using icalbuddy and excluding a calendar I don't want to see
function agenda -d 'prints events from the apple calendar using icalbuddy'
    command icalBuddy -f -ec "" -eed -eep "notes,attendees" eventsToday
end

# print tasks from reminders using icalbuddy
function reminders -d 'prints reminders from apple reminders using icalbuddy'
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed tasksDueBefore:today+1
end

# generate unixtime
function unixtime
    command date +%s $argv
end

# eza ls
function ls
    command eza --sort=type $argv
end

# eza ls -l
function ll
    command eza --sort=type --long --git --no-permissions --no-user --no-time $argv
end

# eza tree
function tree
    command eza --tree $argv
end

# fuzzy find process and kill selected
function fkill
    command ps -e | fzy | awk '{print $1}' | xargs kill
end

# fuzzy find history item
function fzy_history
    set -l currbuff (commandline)
    history | fzy --query=$currbuff | read foo

    if [ $foo ]
        commandline -r ''
        commandline -f repaint
        commandline $foo
    else
        commandline ''
        commandline -f repaint
    end
end

# fuzzy find zoxide directory
function fzy_zoxide
    set -l currbuff (commandline)
    zoxide query -la | fzy --query=$currbuff | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
        commandline -f repaint
    end
end

# fuzzy find all markdown files recursively from current directory
function mdb
    fd . "$(pwd)" -E Library --extension md | fzy | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end

# recursively remove those pesky .DS_Store files
function cleands
    if [ $argv ]
        command find $argv -name '.DS_Store' -exec rm -i {} \;
    else
        command find . -name '.DS_Store' -exec rm -i {} \;
    end
end

# print short form date for journaling or documentation
function day
    command date +"%a %b %d"
end

bind \co fzy_zoxide
bind \cr fzy_history

# # Auto envs - SECURITY RISK
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

# Serene dark fzf
source ~/github.com/serene-theme/themes/fzf/serene-night.sh

# Editor
export EDITOR="hx"

# Zoxide
zoxide init fish | source

# Pew pew!
starship init fish | source
