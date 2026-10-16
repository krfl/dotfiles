function fzy_project
    # Pick a repo under ~/github.com and open helix there in a new Ghostty window.
    # The window starts a normal shell in the project and types `hx .`, so you
    # land back in that shell when you quit helix.
    set -l root ~/github.com
    set -q fzy_project_root; and set root $fzy_project_root

    set -l name (path basename $root/*/ | fzy)
    commandline -f repaint
    test -n "$name"; or return

    osascript \
        -e 'on run argv' \
        -e '  tell application "Ghostty"' \
        -e '    set cfg to new surface configuration' \
        -e '    set initial working directory of cfg to item 1 of argv' \
        -e '    set initial input of cfg to "hx ." & return' \
        -e '    new window with configuration cfg' \
        -e '    activate' \
        -e '  end tell' \
        -e 'end run' \
        $root/$name >/dev/null
end
