local wezterm = require 'wezterm'
local appearance = require 'appearance'
local config = wezterm.config_builder()
local ffam = { family = 'VictorMono Nerd Font', weight = 'DemiBold'}
local fsize = 14

-- Font configuration
config.font = wezterm.font(ffam)
config.font_size = fsize
config.command_palette_font_size = fsize + 2
config.char_select_font_size = fsize + 2
config.cell_width = 1.1
config.line_height = 1.1
config.adjust_window_size_when_changing_font_size = false

-- Theme
config.color_scheme_dirs = { '~/.config/wezterm/colors' }
config.color_scheme = appearance.is_dark() and 'serene-night' or 'serene-day'

-- Window
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"
config.window_frame = { font = wezterm.font(ffam), font_size = fsize }
-- config.window_padding = { left = 10, right = 10, top = 10, bottom = 10 }

-- Tabs
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = false
config.colors = { tab_bar = { background = 'rgba(0,0,0,0)' } }

-- Shell
config.default_prog = { '/opt/homebrew/bin/fish' }

-- Keybinds
config.keys = {
  { key = 'd', mods = 'CMD',            action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT',      action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD',            action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'r', mods = 'CMD',            action = wezterm.action.RotatePanes 'Clockwise' },
  { key = 'j', mods = 'CMD',            action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'k', mods = 'CMD',            action = wezterm.action.ActivatePaneDirection 'Prev' },
  { key = 'r', mods = 'CMD|SHIFT',      action = wezterm.action.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
  { key = 'k', mods = 'CTRL',           action = wezterm.action.ScrollByLine(-1) },
  { key = 'j', mods = 'CTRL',           action = wezterm.action.ScrollByLine(1) },
  { key = 'h', mods = 'CMD|CTRL',       action = wezterm.action.ActivateTabRelative(-1) },
  { key = 'l', mods = 'CMD|CTRL',       action = wezterm.action.ActivateTabRelative(1) },

}

config.key_tables = {
  resize_pane = {
    { key = 'h',      action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = 'j',      action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
    { key = 'k',      action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = 'l',      action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter',  action = 'PopKeyTable' },
  },
}
-- Tab formatting
wezterm.on('format-tab-title', function(tab, tabs, panes, config, hover, max_width)
  local bg = config.resolved_palette and config.resolved_palette.background or '#1e1d1a'
  local fg = config.resolved_palette and config.resolved_palette.foreground or '#d4cfc4'
  local green = config.resolved_palette and config.resolved_palette.ansi[3] or '#8fae7a'

  if not tab.is_active then
    fg = wezterm.color.parse(fg):darken(0.5)
  end

  local title = string.gsub(tab.active_pane.foreground_process_name, '(.*[/\\])(.*)', '%2') or tab.active_pane.title
  if #title > 12 then title = title:sub(1, 12) .. '…' end

  local spacing = tab.tab_index < #tabs - 1 and '   ' or ''
  local prefix = tab.is_active and '● ' or ''

  return {
    { Background = { Color = bg } },
    { Foreground = { Color = green } },
    { Text = prefix },
    { Foreground = { Color = fg } },
    { Text = title .. ' ' .. spacing },
  }
end)

-- Center tabs
wezterm.on('update-status', function(window, pane)
  local tabs = window:mux_window():tabs()
  local mid_width = 0

  for idx, tab in ipairs(tabs) do
    local title = string.gsub(tab:active_pane():get_foreground_process_name() or '', '(.*[/\\])(.*)', '%2') or tab:active_pane():get_title()
    if #title > 12 then title = title:sub(1, 12) .. '…' end

    mid_width = mid_width + math.floor(math.log(idx, 10)) + 1 + 2 + #title + 1
  end

  local tab_width = window:active_tab():get_size().cols
  window:set_left_status(wezterm.pad_left(' ', tab_width / 2 - mid_width / 2))
  window:set_right_status('')
end)

return config
