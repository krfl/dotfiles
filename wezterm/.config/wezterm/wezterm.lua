local wezterm = require 'wezterm'

-- -- auto dark/light theme
-- function scheme_for_appearance(appearance)
--   if appearance:find('Dark') then
--     return 'rasmus'
--   else
--     return 'flatwhite'
--   end
-- end

-- wezterm.on('window-config-reloaded', function(window, pane)
--   local overrides = window:get_config_overrides() or {}
--   local appearance = window:get_appearance()
--   local scheme = scheme_for_appearance(appearance)
--   if overrides.color_scheme ~= scheme then
--     overrides.color_scheme = scheme
--     window:set_config_overrides(overrides)
--   end
-- end)

-- config
return {
    -- color
    color_scheme = 'rasmus',

    -- shell
    default_prog = { '/opt/homebrew/bin/fish' },

    -- font and typeface
    font = wezterm.font_with_fallback({
        'Agave Nerd Font Mono',
        { family = 'Symbols Nerd Font Mono', scale = 0.7 },
    }),

    font_size = 18,
    command_palette_font_size = 20,
    char_select_font_size = 20,
    line_height = 1.4,
    adjust_window_size_when_changing_font_size = false,
    
   -- misc
    hide_tab_bar_if_only_one_tab = true,
    use_fancy_tab_bar = true,
    window_close_confirmation = 'NeverPrompt',
    window_decorations = "INTEGRATED_BUTTONS|RESIZE",
    -- window_background_opacity = 0.85,
    -- window_decorations = "RESIZE",
    initial_rows = 32,
    initial_cols = 132,

    window_frame = {
        font = wezterm.font_with_fallback({
            'Agave Nerd Font Mono',
            { family = 'Symbols Nerd Font Mono', scale = 0.7 },
        }),
        font_size = 18,
    },
    
    keys = {
        { key = 'd', mods = 'CMD',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
        { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
        { key = 'w', mods = 'CMD',       action = wezterm.action.CloseCurrentPane { confirm = true } },
        { key = 'r', mods = 'CMD',       action = wezterm.action.RotatePanes 'Clockwise' },
        { key = 'j', mods = 'CMD',       action = wezterm.action.ActivatePaneDirection 'Next' },
        { key = 'k', mods = 'CMD',       action = wezterm.action.ActivatePaneDirection 'Prev' },
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
