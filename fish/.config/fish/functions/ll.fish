# ll alias using exa
# 'short form' ls -l sorted by type
function ll
    command eza --sort=type --long --git --no-permissions --no-user --no-time $argv
end
