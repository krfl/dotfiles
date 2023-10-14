function __theme_mode -d 'Sets the theme to light or dark depending on interface style'
    switch (defaults read -g AppleInterfaceStyle 2>/dev/null)
        case Dark
            sed -i '' "s/theme =.*/theme = 'rose_pine_moon'/" ~/.config/helix/config.toml
            set -Ux FZF_DEFAULT_OPTS "
            	--color=fg:#908caa,bg:#232136,hl:#ea9a97
            	--color=fg+:#e0def4,bg+:#393552,hl+:#ea9a97
            	--color=border:#44415a,header:#3e8fb0,gutter:#232136
            	--color=spinner:#f6c177,info:#9ccfd8,separator:#44415a
            	--color=pointer:#c4a7e7,marker:#eb6f92,prompt:#908caa"
            command kitty +kitten themes --reload-in=parent Rosé Pine Moon
        case '*'
            sed -i '' "s/theme =.*/theme = 'rose_pine_dawn'/" ~/.config/helix/config.toml
            set -Ux FZF_DEFAULT_OPTS "
            	--color=fg:#797593,bg:#faf4ed,hl:#d7827e
            	--color=fg+:#575279,bg+:#f2e9e1,hl+:#d7827e
            	--color=border:#dfdad9,header:#286983,gutter:#faf4ed
            	--color=spinner:#ea9d34,info:#56949f,separator:#dfdad9
            	--color=pointer:#907aa9,marker:#b4637a,prompt:#797593"
            command kitty +kitten themes --reload-in=parent Rosé Pine Dawn
        end
end
