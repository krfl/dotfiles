local wezterm = require 'wezterm'

-- config
return {
    -- shell
    default_prog = { '/opt/homebrew/bin/fish' },

    -- font and typeface
    font = wezterm.font_with_fallback({
        'Agave Nerd Font Mono',
        { family = 'Symbols Nerd Font Mono', scale = 0.7 },
    }),

    font_size = 18,
    command_palette_font_size = 18,
    char_select_font_size = 18,
    line_height = 1.2,
    adjust_window_size_when_changing_font_size = false,

    -- misc
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = true,
    window_close_confirmation = 'NeverPrompt',

    -- window and color
    -- colors = {
    --     ansi = {
    --         '#605a52',
    --         '#b57c09',
    --         '#bdcd72',
    --         '#eaad61',
    --         '#89a1d1',
    --         '#cf8bcf',
    --         '#84c8b3',
    --         '#4d1dd5',
    --     },
    --     brights = {
    --         '#605a52',
    --         '#b57c09',
    --         '#bdcd72',
    --         '#eaad61',
    --         '#89a1d1',
    --         '#cf8bcf',
    --         '#84c8b3',
    --         '#4d1dd5',
    --     },
        
    --     foreground = '#605a52',
    --     background = '#f7f3ee',

    --     compose_cursor = '#990000',
    --     cursor_bg = '#605a52',
    --     cursor_border = '#605a52',
    --     cursor_fg = '#f7f3ee',

    --     selection_bg = '#dcd3c6',
    --     selection_fg = '#605a52',

    --     -- The color of the scrollbar "thumb"; the portion that represents the current viewport
    --     scrollbar_thumb = '#ff0000',

    --     -- The color of the split lines between panes
    --     split = '#dcd3c6',

    --     tab_bar = {
    --         background = '#e4ddd2',

    --         active_tab = {
    --             fg_color = '#605a52',
    --             bg_color = '#f7f3ee',
    --         },

    --         inactive_tab = {
    --             fg_color = '#605a52',
    --             bg_color = '#e4ddd2',
    --         },

    --         inactive_tab_hover = {
    --             fg_color = '#f7f3ee',
    --             bg_color = '#605a52',
    --         },

    --         new_tab = {
    --             fg_color = '#605a52',
    --             bg_color = '#f7f3ee',
    --         },

    --         new_tab_hover = {
    --             fg_color = '#f7f3ee',
    --             bg_color = '#605a52',
    --         },
    --     },
    --     inactive_tab_edge = '#dcd3c6',
    -- },

    color_scheme = 'flatwhite',

    window_frame = {
        font = wezterm.font_with_fallback({
            'Agave Nerd Font Mono',
            { family = 'Symbols Nerd Font Mono', scale = 0.7 },
        }),
        font_size = 16,
        active_titlebar_fg = '#605a52',
        active_titlebar_bg = '#f7f3ee',
        active_titlebar_border_bottom = '#f7f3ee',
        inactive_titlebar_fg = '#605a52',
        inactive_titlebar_bg = '#e4ddd2',
    },

    keys = {
        { key = 'd', mods = 'CMD',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'w', mods = 'CMD',       action = wezterm.action.CloseCurrentPane { confirm = true } },
        { key = 'r', mods = 'CMD',       action = wezterm.action.RotatePanes 'Clockwise' },
        { key = 'r', mods = 'CMD|SHIFT', action = wezterm.action.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
    },

    key_tables = {
        resize_pane = {
            { key = 'h',      action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
            { key = 'j',      action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
            { key = 'k',      action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
            { key = 'l',      action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
            { key = 'Escape', action = 'PopKeyTable' },
            { key = 'Enter',  action = 'PopKeyTable' },
        }
    }
}
