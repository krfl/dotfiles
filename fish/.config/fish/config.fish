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

function brewup
    command brew update
    command gum confirm --affirmative="Upgrade" --negative="Cancel" --selected.background 9 --selected.foreground 0 && brew upgrade && brew cleanup && brew autoremove && brew doctor  || echo "Upgrade cancelled"
end

function htop
    command htop --tree --sort-key PERCENT_CPU $argv
end

# Peco
function peco_zoxide
  zoxide query -ls | awk '{print $2}' | peco --prompt=" >" | read foo
  if [ $foo ]
    cd $foo
    commandline -f repaint
  else
    commandline ''
  end
end

function peco_history
  history | peco --prompt=" >" | read foo
  if [ $foo ]
    commandline $foo
  else
    commandline ''
  end
end

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
