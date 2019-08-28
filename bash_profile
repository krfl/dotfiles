# github.com/krfl/dotfiles

export TERM=xterm-256color
export EDITOR=nvim
export CLICOLOR=1
export LC_ALL=en_US.UTF-8

bind '\C-TAB:menu-complete'

# HISTORY
export HISTCONTROL=ignoredups:ignorespace
shopt -s histappend

# PATHS
export USER_LOCAL_BIN_PATH='/usr/local/bin'
export USER_LOCAL_SBIN_PATH='/usr/local/sbin'
export USER_BIN_PATH='/usr/bin'
export USER_SBIN_PATH='/usr/sbin'
export BIN_PATH='/bin'
export SBIN_PATH='/sbin'
export PATH=$USER_LOCAL_BIN_PATH:$USER_LOCAL_SBIN_PATH:$USER_BIN_PATH:$USER_SBIN_PATH:$BIN_PATH:$SBIN_PATH:$NPM_PACKAGES_PATH

# Pydo
export PYDO=${HOME}'/.pydo/tasks.pydo'
alias pydo='python3 '${HOME}'/dev/pydo/pydo.py'

# Generic aliases
alias cp='cp -iv'
alias mv='mv -iv'
alias mkdir='mkdir -pv'

# Prefered listing
alias ls='ls -hGF'
alias ll='ls -lh'
alias cls='clear && ls'
alias clsa='clear && ls -a'
alias cll='clear && ls -1'
alias clla='clear && ls -1a'

# Mac specific
if [[ $TERM_PROGRAM == "iTerm.app" || $TERM_PROGRAM == "Apple_Terminal" ]]; then
    alias gotoicloud='cd ~/Library/Mobile\ Documents/com~apple~CloudDocs/'
fi

# NVIM
if [[ $TERM_PROGRAM == "iTerm.app" || $TERM_PROGRAM == "Hyper" ]]; then alias vim='nvim'; fi

# Python specific
alias python='python -B'
alias python3='python3 -B'
alias activate='source .venv/bin/activate'

# Homebrew specific
alias brewup='brew update; brew upgrade; brew cleanup; brew doctor'

# Update all the things
alias update_all_the_things="tldr --update; brewup"

# NPM
# alias npm-exec='PATH=$(npm bin):$PATH'

# Prompt function for PROMPT_COMMAND
set_prompt() {
    # colors
    local txtblk='\[\e[1;30m\]' # black
    local txtred='\[\e[1;31m\]' # red
    local txtgrn='\[\e[1;32m\]' # green
    local txtylw='\[\e[1;33m\]' # yellow
    local txtblu='\[\e[1;34m\]' # blue
    local txtpur='\[\e[1;35m\]' # purple
    local txtcyn='\[\e[1;36m\]' # cyan
    local txtwht='\[\e[1;37m\]' # white
    local reset='\[\e[0m\]'     # reset
    local space="${reset} "
    # path
    path="${txtylw}$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")"
    # Python venv
    venv=""
    if [[ $VIRTUAL_ENV != "" ]]; then venv="${space}${txtpur}${VIRTUAL_ENV##*/}"; fi
    # Git branch
    branch=""
    ref="$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')"
    if [[ "$ref" != "" ]]; then branch="${space}${txtred}$ref"; fi
    # Git dirtyness
    dirty=""
    if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then dirty="*"; fi
    # Set prompt
    PS1="${path}${venv}${branch}${dirty}${space}\$ "
}

export PROMPT_COMMAND=set_prompt
eval "$(thefuck --alias)"
clear
