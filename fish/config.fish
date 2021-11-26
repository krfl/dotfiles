# Greeting
function fish_greeting
    command clear
    command date +"%d/%m/%Y"
    command date +"%H:%M:%S"
    command task next
end

function gotoicloud
    cd ~/Library/Mobile\ Documents/com\~apple\~CloudDocs/
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

function python3
    command python3 -B $argv
end

# Homebrew specific
function brewup
    command brew update
    command brew upgrade
    command brew cleanup
    command brew doctor
    command echo "Done!"
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

function autoonefetch --on-variable PWD
    if test -d $PWD/.git
        command onefetch
    end
end

# Universal variables
set -U EDITOR vim
set -U fish_user_paths /usr/local/sbin/ $fish_user_paths
set -U fish_user_paths /usr/local/bin $fish_user_paths
set -U fish_user_paths /usr/local/opt/openjdk@11/bin $fish_user_paths
set -U ANDROID_SDK_ROOT ~/Library/Android/sdk/

# Environment variables
set -x BAT_THEME ansi

# Pew pew!
starship init fish | source
thefuck --alias | source
rvm default
