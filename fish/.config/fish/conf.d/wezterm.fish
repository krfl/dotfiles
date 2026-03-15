# Publish git branch to wezterm via user vars
function __wezterm_set_git_branch --on-variable PWD
    set -l branch (command git branch --show-current 2>/dev/null)
    printf "\033]1337;SetUserVar=git_branch=%s\007" (printf '%s' "$branch" | base64)
end

# Run on startup
__wezterm_set_git_branch
