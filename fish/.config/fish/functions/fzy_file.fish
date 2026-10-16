function fzy_file
    # Pick a file below the current directory and insert its path at the cursor.
    # The token under the cursor is used as the starting query and gets replaced.
    set -l token (commandline -t)
    rg --files --hidden --glob '!.git' 2>/dev/null | fzy --query=$token | read -l file
    if test -n "$file"
        commandline -rt -- (string escape -- $file)
    end
    commandline -f repaint
end
