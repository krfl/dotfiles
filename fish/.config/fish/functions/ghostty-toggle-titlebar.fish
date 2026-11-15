function ghostty-toggle-titlebar --description 'Toggle the Ghostty titlebar, handy for clean screenshots of TUI apps'
    set -l active "$HOME/.config/ghostty/titlebar.conf"

    set -l next_label
    if test -f $active; and grep -q '^macos-titlebar-style = hidden' $active
        rm $active
        set next_label shown
    else
        echo 'macos-titlebar-style = hidden' >$active
        set next_label hidden
    end

    if not killall -USR2 ghostty 2>/dev/null
        echo "ghostty titlebar -> $next_label (no running ghostty; takes effect on next launch)"
        return 0
    end

    # Ghostty only applies the titlebar style to windows created after the
    # reload, so give it a moment to pick up the config and open a fresh one.
    sleep 0.3
    if osascript -e 'tell application "Ghostty" to new window' >/dev/null 2>&1
        echo "ghostty titlebar -> $next_label (reloaded, opened a new window)"
    else
        echo "ghostty titlebar -> $next_label (reloaded; open a new window to see it)"
    end
end
