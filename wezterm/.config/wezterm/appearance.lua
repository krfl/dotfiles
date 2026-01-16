local wezterm = require 'wezterm'
local module = {}

function module.smart_colorscheme()
  if wezterm.gui.get_appearance():find "Dark" then
    io.popen("sed -i '' 's/serene-day-clarity/serene-night-clarity/' ~/github.com/dotfiles/helix/.config/helix/config.toml"):close()
    return "serene-night"
  else
    io.popen("sed -i '' 's/serene-night-clarity/serene-day-clarity/' ~/github.com/dotfiles/helix/.config/helix/config.toml"):close()
    return "serene-day"
  end
end

return module
