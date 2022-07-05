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
    command clear
    command exa --sort=type --icons $argv
end

function ll
    command clear
    command exa --sort=type --icons --long $argv
end

function vim
    command hx $argv
    #command nvim $argv
end

function tree
    command exa --tree $argv
end

function mon
    command top -o cpu -O time $argv
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

# Env
export LC_CTYPE="en_US.UTF-8"

# Pew pew!
starship init fish | source

