local wezterm = require 'wezterm'
local appearance = require 'appearance'

local config = wezterm.config_builder()
local ffam = { family = 'JetBrains Mono', weight = 'Medium'}
local fsize = 14

-- adapt to os theme
if appearance.is_dark() then
  config.color_scheme = 'rose-pine-moon'
else
  config.color_scheme = 'flatwhite'
end

-- window
-- config.window_background_opacity = 0.9
-- config.macos_window_background_blur = 30
-- config.use_fancy_tab_bar = false
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"
-- config.initial_rows = 36
-- config.initial_cols = 112

config.window_padding = {
  left = 25,
  right = 25,
  top = 25,
  bottom = 25,
}

config.window_frame = {
  font = wezterm.font(ffam),
  font_size = fsize,
}

-- font and typeface
config.font = wezterm.font(ffam)
config.font_size = fsize
config.command_palette_font_size = 20
config.char_select_font_size = 20
config.line_height = 1.2
config.adjust_window_size_when_changing_font_size = false

-- shell
config.default_prog = { '/opt/homebrew/bin/fish' }

-- keybinds
config.keys = {
  { key = 'd', mods = 'CMD',       action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 'd', mods = 'CMD|SHIFT', action = wezterm.action.SplitVertical { domain = 'CurrentPaneDomain' } },
  { key = 'w', mods = 'CMD',       action = wezterm.action.CloseCurrentPane { confirm = true } },
  { key = 'r', mods = 'CMD',       action = wezterm.action.RotatePanes 'Clockwise' },
  { key = 'j', mods = 'CMD',       action = wezterm.action.ActivatePaneDirection 'Next' },
  { key = 'k', mods = 'CMD',       action = wezterm.action.ActivatePaneDirection 'Prev' },
  { key = 'r', mods = 'CMD|SHIFT', action = wezterm.action.ActivateKeyTable { name = 'resize_pane', one_shot = false } },
  { key = 'k', mods = 'CTRL',      action = wezterm.action.ScrollByLine(-1) },
  { key = 'j', mods = 'CTRL',      action = wezterm.action.ScrollByLine(1) },
}

config.key_tables = {
  resize_pane = {
    { key = 'h',      action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = 'j',      action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
    { key = 'k',      action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = 'l',      action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter',  action = 'PopKeyTable' },
  }
}

-- extras 
local wezterm = require 'wezterm'

local function segments_for_right_status(window)
  -- battery
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = string.format('%.0f%%', b.state_of_charge * 100)
  end

  return {
    window:active_workspace(),
    bat,
    wezterm.strftime('%a %b %-d %H:%M'),
    -- wezterm.hostname(),
  }
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  local color_scheme = window:effective_config().resolved_palette
  local bg = wezterm.color.parse(color_scheme.background)
  local fg = color_scheme.foreground

  local gradient_to, gradient_from = bg
  if appearance.is_dark() then
    gradient_from = gradient_to:lighten(0.2)
  else
    gradient_from = gradient_to:darken(0.2)
  end

  local gradient = wezterm.color.gradient(
    {
      orientation = 'Horizontal',
      colors = { gradient_from, gradient_to },
    },
    #segments -- only gives us as many colors as we have segments.
  )

  local elements = {}

  for i, seg in ipairs(segments) do
    local is_first = i == 1

    if is_first then
      table.insert(elements, { Background = { Color = 'none' } })
    end
    table.insert(elements, { Foreground = { Color = gradient[i] } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })

    table.insert(elements, { Foreground = { Color = fg } })
    table.insert(elements, { Background = { Color = gradient[i] } })
    table.insert(elements, { Text = ' ' .. seg .. ' ' })
  end

  window:set_right_status(wezterm.format(elements))
end)

return config
