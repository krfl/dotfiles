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

# print calendar events using icalbuddy and excluding a calendar I don't want to see
function __calendar -d 'prints events from the apple calendar using icalbuddy'
    command icalBuddy -f -ec "" -eed -eep "notes,attendees" eventsToday
end

# print tasks from reminders using icalbuddy
function __reminders -d 'prints reminders from apple reminders using icalbuddy'
    command icalBuddy -f -sc -ss "" -npn -nc -iep "title,datetime" -ps "| : |" -po "datetime,title" -tf "" -df "%RD" -eed tasksDueBefore:today+1
end

# generate unixtime
function unixtime
    command date +%s $argv
end

function ls
    command eza --sort=type $argv
end

function ll
    command eza --sort=type --long --git --no-permissions --no-user --no-time $argv
end

function tree
    command eza --tree $argv
end

# feeds history into fzf for filtering
function fzf_history
    set -l currbuff (commandline)
    history | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --tabstop=1 --border=sharp --height=45% --info=inline --layout=reverse --exit-0 --select-1 --query $currbuff | read foo

    if [ $foo ]
        commandline -r ''
        commandline -f repaint
        commandline $foo
    else
        commandline ''
        commandline -f repaint
    end
end

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

# feeds zoxide directories into fzf for filtering 
function fzf_zoxide
    set -l currbuff (commandline)
    zoxide query -la | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:up,tab:down --cycle --keep-right --tabstop=1 --border=sharp --height=45% --info=inline --layout=reverse --exit-0 --select-1 --query $currbuff | read foo
    if [ $foo ]
        cd $foo
        commandline -f repaint
    else
        commandline ''
        commandline -f repaint
    end
end

# feeds zoxide directories into fzy for filtering 
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

# htop alias
# tree view and sorted by cpu usage
function htop --wraps htop --description 'alias htop=htop --tree --sort-key PERCENT_CPU'
    command htop --tree --sort-key PERCENT_CPU $argv
end

# markdown brain
# lets me easily find the markdown document I'm looking for through peco's filtering. 
function mdb
    # fd . "$(pwd)" -E Library --extension md | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:down,tab:up --cycle --keep-right --tabstop=1 --exit-0 --select-1 | read foo
    fd . "$(pwd)" -E Library --extension md | fzy | read foo
    if [ $foo ]
        command hx $foo
    else
        commandline ''
    end
end

# markdown preview
function mdprev
    if [ $argv ]
        ls *.md | entr -c glow -p $argv
    else
        ls *.md | entr -c glow -p (ls *.md | fzf --exact --no-sort --bind=ctrl-z:ignore,btab:down,tab:up --cycle --keep-right --tabstop=1 --exit-0 --select-1)
    end
end

# remove those pesky .DS_Store files
function clean-ds
    if [ $argv ]
        command find $argv -name '.DS_Store' -exec rm -i {} \;
    else
        command find . -name '.DS_Store' -exec rm -i {} \;
    end
end

function day
    command date +"%a %b %d"
end

function bat
    command bat -p $argv
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

# Env
# export LC_CTYPE="en_US.UTF-8"
# export PYTHONDONTWRITEBYTECODE=1
# export LS_COLORS="Gxfxcxdxbxegedabagacad"
# export CLICOLOR=1

# Editor
export EDITOR="hx"

# Zoxide
zoxide init fish | source

# Pew pew!
starship init fish | source
