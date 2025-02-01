local wezterm = require 'wezterm'

local config = wezterm.config_builder()

config.font = wezterm.font 'JetBrains Mono'

config.color_scheme = 'Batman'

-- Show which key table is active in the status area
wezterm.on('update-right-status', function(window, pane)
  local name = window:active_key_table()
  if name then
    name = 'TABLE: ' .. name
  end
  window:set_right_status(name or '')
end)

config.leader = { key = 'Space', mods = 'CTRL|SHIFT' }
config.keys = {
  {
		key = 'q',
		mods = 'CTRL|SHIFT',
		action = wezterm.action.CloseCurrentPane {confirm=true},
	},
  -- CTRL+SHIFT+Space, followed by 'r' will put us in resize-pane
  -- mode until we cancel that mode.
  {
    key = 'r',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'resize_pane',
      one_shot = false,
    },
  },

  -- CTRL+SHIFT+Space, followed by 'a' will put us in activate-pane
  -- mode until we press some other key or until 1 second (1000ms)
  -- of time elapses
  {
    key = 'a',
    mods = 'LEADER',
    action = wezterm.action.ActivateKeyTable {
      name = 'activate_pane',
      timeout_milliseconds = 1000,
    },
  },
}

config.key_tables = {
  -- Defines the keys that are active in our resize-pane mode.
  -- Since we're likely to want to make multiple adjustments,
  -- we made the activation one_shot=false. We therefore need
  -- to define a key assignment for getting out of this mode.
  -- 'resize_pane' here corresponds to the name="resize_pane" in
  -- the key assignments above.
  resize_pane = {
    { key = 'LeftArrow', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },
    { key = 'h', action = wezterm.action.AdjustPaneSize { 'Left', 1 } },

    { key = 'RightArrow', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },
    { key = 'l', action = wezterm.action.AdjustPaneSize { 'Right', 1 } },

    { key = 'UpArrow', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },
    { key = 'k', action = wezterm.action.AdjustPaneSize { 'Up', 1 } },

    { key = 'DownArrow', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },
    { key = 'j', action = wezterm.action.AdjustPaneSize { 'Down', 1 } },

    -- Cancel the mode by pressing escape
    { key = 'Escape', action = 'PopKeyTable' },
  },

  -- Defines the keys that are active in our activate-pane mode.
  -- 'activate_pane' here corresponds to the name="activate_pane" in
  -- the key assignments above.
  activate_pane = {
    { key = 'LeftArrow', action = wezterm.action.ActivatePaneDirection 'Left' },
    { key = 'h', action = wezterm.action.ActivatePaneDirection 'Left' },

    { key = 'RightArrow', action = wezterm.action.ActivatePaneDirection 'Right' },
    { key = 'l', action = wezterm.action.ActivatePaneDirection 'Right' },

    { key = 'UpArrow', action = wezterm.action.ActivatePaneDirection 'Up' },
    { key = 'k', action = wezterm.action.ActivatePaneDirection 'Up' },

    { key = 'DownArrow', action = wezterm.action.ActivatePaneDirection 'Down' },
    { key = 'j', action = wezterm.action.ActivatePaneDirection 'Down' },
  },
}
return config
