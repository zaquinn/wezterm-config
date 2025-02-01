local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'

config.color_scheme = 'Batman'

config.keys = {
	{
		key = 'q',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CloseCurrentPane {confirm=true},
	}
}

return config
