local wezterm = require 'wezterm'
local module = {}

function module.smart_colorscheme()
  if wezterm.gui.get_appearance():find "Dark" then
    return "serene-night"
  else
    return "serene-day"
  end
end

return module
