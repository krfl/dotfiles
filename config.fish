# Greeting
function fish_greeting
    command clear && gcal --starting-day=1 --with-week-number --iso-week-number=yes --highlight=no | grep --color -EC6 "\b"(date +%e | sed "s/ //g")
    # command date +"%H:%M:%S"
end

# Functions
function ls
    command exa -bF $argv
end

function cls
    command clear
    command exa -bF $argv
end

function cll
    command clear
    command exa -bFl $argv
end

function tree
    command exa --tree $argv
end

function mon
    command top -o cpu -O time $argv
end

function python
    command python -B $argv
end

# Mac specific
function brewup
    command brew update
    command brew upgrade
    command brew cleanup
    command brew doctor
end

# Auto envs
function autovenv --on-variable PWD
    if test -d $PWD/.venv
        source .venv/bin/activate.fish &
    end
end

function autoenv --on-variable PWD
    if test -d $PWD/.env
        source $PWD/.env
    end
end

# Universal variables
set -U EDITOR vim
set -U fish_user_paths /usr/local/sbin/

# Environment variables
set -x BAT_THEME ansi-dark

# Pew pew!
starship init fish | source
thefuck --alias | source

