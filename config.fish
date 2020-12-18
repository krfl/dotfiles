# Alias
alias python="python -B"

# Functions
function ls
    command ls -hGF $argv
end

function cls
    command clear
    command ls -hGF $argv
end

function cll
    command clear
    command ls -hGFl1 $argv
end

function venv
    source .venv/bin/activate.fish
end

# Python
function python
    command python -B
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
set -x BAT_THEME Nord

# Pew pew!
starship init fish | source
thefuck --alias | source
