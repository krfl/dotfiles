# github.com/krfl/dotfiles

export TERM=xterm-256color
export EDITOR=vim
export CLICOLOR=1

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
export DOTNET_HOME="/usr/local/share/dotnet"
export PYDO_HOME='/Users/krfl/.pydo/tasks.pydo'
export PATH=$USER_LOCAL_BIN_PATH:$USER_LOCAL_SBIN_PATH:$USER_BIN_PATH:$USER_SBIN_PATH:$BIN_PATH:$SBIN_PATH:$NPM_PACKAGES_PATH:$DOTNET_HOME

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

# PROMPT
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;33m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;36m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
bakgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
reset='\[\e[0m\]'    # Text Reset


# Prompt function for PROMPT_COMMAND
set_prompt() {
    local space=" "
    # path
    path="\[$(p="${PWD#${HOME}}"; [ "${PWD}" != "${p}" ] && printf "~";IFS=/; for q in ${p:1}; do printf /${q:0:1}; done; printf "${q:1}")\]"
    # Python venv
    venv=""
    if [[ $VIRTUAL_ENV != "" ]]; then venv="\[${space}${VIRTUAL_ENV##*/}\]"; fi
    # Git branch
    branch=""
    ref="\[$(git symbolic-ref HEAD 2> /dev/null | sed -e 's/refs\/heads\///')\]"
    if [[ "$ref" != "" ]]; then branch="${space}$ref"; fi
    # Git dirtyness
    dirty=" "
    if [[ -n "$(git status --porcelain 2> /dev/null)" ]]; then dirty="* "; fi
    # Set prompt
    PS1="\[${txtcyn}${path}${txtgrn}${venv}${txtred}${branch}${dirty}${reset}\$ \]"
}

export PROMPT_COMMAND=set_prompt
eval "$(thefuck --alias)"
clear
