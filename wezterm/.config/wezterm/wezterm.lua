local wezterm = require 'wezterm'
local appearance = require 'appearance'
local config = wezterm.config_builder()
local ff = 'SauceCodePro Nerd Font'
local ffam = { family = ff, weight = 'Medium'}
local fsize = 12

-- Font configuration
config.font = wezterm.font(ffam)
config.font_rules = {
  { intensity = 'Bold', font = wezterm.font(ff, { weight = 'Bold' }), },
  { intensity = 'Bold', italic = true, font = wezterm.font(ff, { weight = 'Bold', italic = true }) }, }
config.font_size = fsize
config.command_palette_font_size = fsize + 2
config.char_select_font_size = fsize + 2
config.cell_width = 0.9
config.line_height = 1.3
config.adjust_window_size_when_changing_font_size = false

-- Theme
config.color_scheme_dirs = { '~/.config/wezterm/colors' }
config.color_scheme = appearance.smart_colorscheme()

-- Window
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"
config.window_frame = { font = wezterm.font(ffam), font_size = fsize }
config.window_padding = { left = 20, right = 20, top = 20, bottom = 20 }

-- Tabs
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.show_tab_index_in_tab_bar = false
config.tab_max_width = 32
config.hide_tab_bar_if_only_one_tab = true
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
  { key = 'e', mods = 'CMD',            action = wezterm.action.PromptInputLine {
    description = 'Enter new name for tab',
    action = wezterm.action_callback(function(window, pane, line)
      if line then
        window:active_tab():set_title(line)
      end
    end),
  }},
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

-- Tab bar helpers
local process_icons = {
  ['fish']    = wezterm.nerdfonts.md_fish,
  ['bash']    = wezterm.nerdfonts.cod_terminal_bash,
  ['zsh']     = wezterm.nerdfonts.dev_terminal,
  ['nvim']    = wezterm.nerdfonts.custom_neovim,
  ['vim']     = wezterm.nerdfonts.dev_vim,
  ['hx']      = wezterm.nerdfonts.md_pencil,
  ['git']     = wezterm.nerdfonts.dev_git,
  ['lazygit'] = wezterm.nerdfonts.dev_git,
  ['node']    = wezterm.nerdfonts.md_nodejs,
  ['python']  = wezterm.nerdfonts.dev_python,
  ['python3'] = wezterm.nerdfonts.dev_python,
  ['cargo']   = wezterm.nerdfonts.dev_rust,
  ['go']      = wezterm.nerdfonts.md_language_go,
  ['docker']  = wezterm.nerdfonts.dev_docker,
  ['kubectl'] = wezterm.nerdfonts.md_kubernetes,
  ['ssh']     = wezterm.nerdfonts.md_server,
  ['htop']    = wezterm.nerdfonts.md_chart_line,
  ['btm']     = wezterm.nerdfonts.md_chart_line,
  ['make']    = wezterm.nerdfonts.md_wrench,
  ['claude']  = wezterm.nerdfonts.md_robot_outline,
}

local function get_process_icon(name)
  local short = string.gsub(name or '', '(.*[/\\])(.*)', '%2')
  return process_icons[short] or wezterm.nerdfonts.cod_terminal
end

local function get_title(process_name, pane_title, custom_title, max_len)
  max_len = max_len or 12
  local proc = string.gsub(process_name or '', '(.*[/\\])(.*)', '%2')
  local title = (custom_title and #custom_title > 0 and custom_title)
    or (#proc > 0 and proc)
    or pane_title
    or 'shell'
  if #title > max_len then title = title:sub(1, max_len) .. '…' end
  return title
end

-- Tab formatting (Dashboard)
wezterm.on('format-tab-title', function(tab, tabs, panes, cfg, hover, max_width)
  local palette = cfg.resolved_palette or {}
  local bg = palette.background or '#1e1d1a'
  local fg = palette.foreground or '#d4cfc4'
  local green = palette.ansi and palette.ansi[3] or '#8fae7a'

  local _, _, bg_lum, _ = wezterm.color.parse(bg):hsla()
  local is_dark = bg_lum < 0.5

  local hover_bg = is_dark
    and wezterm.color.parse(bg):lighten(0.03)
    or wezterm.color.parse(bg):darken(0.02)
  local inactive_fg = is_dark
    and wezterm.color.parse(fg):darken(0.6)
    or wezterm.color.parse(fg):lighten(0.6)

  local tab_bg, icon_fg, name_fg

  if tab.is_active then
    tab_bg = bg
    icon_fg = green
    name_fg = fg
  elseif hover then
    tab_bg = bg
    icon_fg = palette.ansi and palette.ansi[6] or '#b8956d'
    name_fg = is_dark
      and wezterm.color.parse(fg):darken(0.3)
      or wezterm.color.parse(fg):lighten(0.3)
  else
    tab_bg = bg
    icon_fg = inactive_fg
    name_fg = inactive_fg
  end

  local title = get_title(
    tab.active_pane.foreground_process_name,
    tab.active_pane.title,
    tab.tab_title
  )
  local icon = get_process_icon(tab.active_pane.foreground_process_name)
  local spacing = tab.tab_index < #tabs - 1 and '   ' or ''

  local elements = {
    { Background = { Color = tab_bg } },
    { Foreground = { Color = icon_fg } },
    { Text = ' ' .. icon .. ' ' },
    { Foreground = { Color = name_fg } },
  }

  if tab.is_active then
    table.insert(elements, { Attribute = { Intensity = 'Bold' } })
  end

  table.insert(elements, { Text = title .. ' ' })

  if tab.is_active then
    table.insert(elements, { Attribute = { Intensity = 'Normal' } })
  end

  table.insert(elements, { Background = { Color = bg } })
  table.insert(elements, { Text = spacing })

  return elements
end)

-- Status bar: left margin + right status (cwd, git branch, clock)
wezterm.on('update-status', function(window, pane)
  window:set_left_status(' ')

  local palette = window:effective_config().resolved_palette or {}
  local bg = palette.background or '#1e1d1a'
  local fg = palette.foreground or '#d4cfc4'
  local green = palette.ansi and palette.ansi[3] or '#8fae7a'
  local yellow = palette.ansi and palette.ansi[4] or '#d4a574'
  local stone = palette.ansi and palette.ansi[7] or '#a89984'

  local _, _, bg_lum, _ = wezterm.color.parse(bg):hsla()
  local sep_fg = bg_lum < 0.5
    and wezterm.color.parse(fg):darken(0.6)
    or wezterm.color.parse(fg):lighten(0.6)

  -- CWD
  local cwd = ''
  local cwd_uri = pane:get_current_working_dir()
  if cwd_uri then
    local path = cwd_uri.file_path or ''
    local home = os.getenv('HOME') or ''
    if path:sub(1, #home) == home then
      path = '~' .. path:sub(#home + 1)
    end
    if #path > 1 and path:sub(-1) == '/' then
      path = path:sub(1, -2)
    end
    local parts = {}
    for part in path:gmatch('[^/]+') do table.insert(parts, part) end
    if #parts > 2 then
      cwd = '…/' .. parts[#parts - 1] .. '/' .. parts[#parts]
    else
      cwd = path
    end
  end

  -- Git branch via user var (set by fish)
  local git_branch = pane:get_user_vars().git_branch or ''

  local right = {
    { Background = { Color = bg } },
    { Foreground = { Color = sep_fg } },
    { Text = '│ ' },
    { Foreground = { Color = yellow } },
    { Text = wezterm.nerdfonts.md_folder_outline .. ' ' },
    { Foreground = { Color = stone } },
    { Text = cwd },
  }

  if #git_branch > 0 then
    table.insert(right, { Text = '   ' })
    table.insert(right, { Foreground = { Color = green } })
    table.insert(right, { Text = wezterm.nerdfonts.dev_git_branch .. ' ' .. git_branch })
  end

  table.insert(right, { Text = '   ' })
  table.insert(right, { Foreground = { Color = yellow } })
  table.insert(right, { Text = wezterm.nerdfonts.md_clock_outline .. ' ' })
  table.insert(right, { Foreground = { Color = stone } })
  table.insert(right, { Text = wezterm.strftime('%H:%M') .. ' ' })

  window:set_right_status(wezterm.format(right))
end)

return config
