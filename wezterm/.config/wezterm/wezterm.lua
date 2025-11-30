local wezterm = require 'wezterm'
local appearance = require 'appearance'

local config = wezterm.config_builder()
local ffam = { family = 'JetBrains Mono', weight = 'Medium'}
local fsize = 15

-- adapt to os theme
config.color_scheme_dirs = { '~/.config/wezterm/colors' }
if appearance.is_dark() then
  config.color_scheme = 'serene-night'
else
  config.color_scheme = 'serene-day'
end

-- window
config.window_close_confirmation = 'NeverPrompt'
config.window_decorations = "RESIZE"

-- config.window_padding = {
--   left = 0,
--   right = 0,
--   top = 0,
--   bottom = 0,
-- }

config.window_frame = {
  font = wezterm.font(ffam),
  font_size = fsize -2,
}

-- font and typeface
config.font = wezterm.font(ffam)
config.font_size = fsize
config.command_palette_font_size = fsize+2
config.char_select_font_size = fsize+2
config.line_height = 1.1
config.adjust_window_size_when_changing_font_size = false

-- shell
config.default_prog = { '/opt/homebrew/bin/fish' }

-- Pomodoro Timer Configuration
local pomodoro = {
  work_duration = 25 * 60,    -- 25 minutes in seconds
  break_duration = 5 * 60,     -- 5 minutes in seconds
  remaining = 0,
  is_running = false,
  is_paused = false,
  is_work = true,
  last_update = 0,
}

-- Pomodoro User Commands
wezterm.on('user-var-changed', function(window, pane, name, value)
  wezterm.log_info('var changed', name, value)
end)

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
  -- Pomodoro keybind - activate pomodoro key table
  { key = 'p', mods = 'CMD|SHIFT|CTRL', action = wezterm.action.ActivateKeyTable { name = 'pomodoro', one_shot = true } },
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
  pomodoro = {
    { key = 's',      action = wezterm.action.EmitEvent 'pomodoro-start' },
    { key = 'p',      action = wezterm.action.EmitEvent 'pomodoro-pause' },
    { key = 'x',      action = wezterm.action.EmitEvent 'pomodoro-stop' },
    { key = 'Escape', action = 'PopKeyTable' },
    { key = 'Enter',  action = 'PopKeyTable' },
  }
}

-- Pomodoro Timer Functions
local function pomodoro_start()
  if not pomodoro.is_running then
    pomodoro.is_running = true
    pomodoro.is_paused = false
    pomodoro.is_work = true
    pomodoro.remaining = pomodoro.work_duration
    pomodoro.last_update = os.time()
  end
end

local function pomodoro_stop()
  pomodoro.is_running = false
  pomodoro.is_paused = false
  pomodoro.remaining = 0
end

local function pomodoro_pause()
  if pomodoro.is_running then
    pomodoro.is_paused = not pomodoro.is_paused
    if not pomodoro.is_paused then
      pomodoro.last_update = os.time()
    end
  end
end

local function pomodoro_update()
  if pomodoro.is_running and not pomodoro.is_paused then
    local now = os.time()
    local elapsed = now - pomodoro.last_update
    pomodoro.last_update = now

    pomodoro.remaining = pomodoro.remaining - elapsed

    if pomodoro.remaining <= 0 then
      -- Switch between work and break
      pomodoro.is_work = not pomodoro.is_work
      if pomodoro.is_work then
        pomodoro.remaining = pomodoro.work_duration
      else
        pomodoro.remaining = pomodoro.break_duration
      end
    end
  end
end

local function get_pomodoro_status()
  if not pomodoro.is_running then
    return ''
  end

  pomodoro_update()

  local minutes = math.floor(pomodoro.remaining / 60)
  local seconds = pomodoro.remaining % 60
  local time_str = string.format('%02d:%02d', minutes, seconds)
  local mode = pomodoro.is_work and 'WORK' or 'BREAK'

  if pomodoro.is_paused then
    return mode .. ' ' .. time_str .. ' (PAUSED)'
  else
    return mode .. ' ' .. time_str
  end
end

-- Pomodoro Event Handlers
wezterm.on('pomodoro-start', function(window, pane)
  pomodoro_start()
  window:toast_notification('WezTerm', 'Pomodoro started!', nil, 2000)
end)

wezterm.on('pomodoro-stop', function(window, pane)
  pomodoro_stop()
  window:toast_notification('WezTerm', 'Pomodoro stopped!', nil, 2000)
end)

wezterm.on('pomodoro-pause', function(window, pane)
  pomodoro_pause()
  local msg = pomodoro.is_paused and 'Pomodoro paused' or 'Pomodoro resumed'
  window:toast_notification('WezTerm', msg, nil, 2000)
end)

-- segments
local function get_cpu_usage()
  -- Get total CPU usage across all processes
  local success_cpu, stdout_cpu = wezterm.run_child_process({
    'sh', '-c',
    "ps -A -o %cpu | awk '{s+=$1} END {print s}'"
  })

  -- Get number of CPU cores
  local success_cores, stdout_cores = wezterm.run_child_process({
    'sysctl', '-n', 'hw.ncpu'
  })

  if success_cpu and success_cores then
    local cpu_total = tonumber(stdout_cpu)
    local cores = tonumber(stdout_cores)
    if cpu_total and cores and cores > 0 then
      local cpu_avg = cpu_total / cores
      return string.format('CPU %.0f%%', cpu_avg)
    end
  end
  return 'CPU --'
end

local function get_memory_usage()
  -- Get used memory via vm_stat
  local success, stdout = wezterm.run_child_process({
    'sh', '-c',
    "vm_stat | awk '/Pages active/ {active=$3} /Pages wired/ {wired=$4} END {gsub(/\\./, \"\", active); gsub(/\\./, \"\", wired); print (active+wired)*4096/1024/1024}'"
  })

  -- Get total system memory
  local success_total, stdout_total = wezterm.run_child_process({
    'sysctl', '-n', 'hw.memsize'
  })

  if success and success_total then
    local mem_used_mb = tonumber(stdout)
    local mem_total_bytes = tonumber(stdout_total)
    if mem_used_mb and mem_total_bytes then
      local mem_total_mb = mem_total_bytes / 1024 / 1024
      local mem_percent = (mem_used_mb / mem_total_mb) * 100
      return string.format('MEM %.0f%%', mem_percent)
    end
  end
  return 'MEM --'
end

local function get_temperature()
  -- Try to get CPU temperature using powermetrics
  local success, stdout, stderr = wezterm.run_child_process({
    'sh', '-c',
    "sudo powermetrics --samplers smc -i1 -n1 2>/dev/null | grep -i 'CPU die temperature' | awk '{print $4}' | cut -d'.' -f1"
  })
  if success and stdout and stdout ~= '' then
    local temp = stdout:gsub('%s+$', '')
    if temp ~= '' then
      return temp .. '°C'
    end
  end
  return ''
end

local function segments_for_right_status(window)
  -- battery
  local bat = ''
  for _, b in ipairs(wezterm.battery_info()) do
    bat = string.format('BAT %.0f%%', b.state_of_charge * 100)
  end

  local segments = {
    get_cpu_usage(),
    get_memory_usage(),
    bat,
    wezterm.strftime('%a %b %-d %H:%M'),
  }

  -- Add temperature if available (requires sudo, might not work)
  local temp = get_temperature()
  if temp ~= '' then
    table.insert(segments, 4, temp)
  end

  -- Add pomodoro timer if running
  local pomo = get_pomodoro_status()
  if pomo ~= '' then
    table.insert(segments, 1, pomo)
  end

  return segments
end

wezterm.on('update-status', function(window, _)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)
  local segments = segments_for_right_status(window)

  -- Add key table indicator if active
  local key_table = window:active_key_table()
  if key_table then
    if key_table == 'pomodoro' then
      table.insert(segments, 1, 'POMODORO: s=start p=pause x=stop esc=exit')
    end
  end

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
