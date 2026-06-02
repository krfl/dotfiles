function ghostty-toggle-rendering --description 'Toggle Ghostty font rendering between retina and external-display presets'
    set -l ghostty_dir "$HOME/.config/ghostty"
    set -l active "$ghostty_dir/rendering.conf"
    set -l retina "$ghostty_dir/rendering.retina.conf"
    set -l external "$ghostty_dir/rendering.external.conf"

    for f in $retina $external
        if not test -f $f
            echo "ghostty-toggle-rendering: missing preset $f" >&2
            return 1
        end
    end

    set -l next_label
    set -l next_source
    if test -f $active; and grep -q '^font-thicken = true' $active
        set next_source $retina
        set next_label retina
    else
        set next_source $external
        set next_label external
    end

    cp $next_source $active

    if killall -USR2 ghostty 2>/dev/null
        echo "ghostty rendering -> $next_label (reloaded)"
    else
        echo "ghostty rendering -> $next_label (no running ghostty; takes effect on next launch)"
    end
end
