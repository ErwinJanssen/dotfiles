-- Pull in the wezterm API.
local wezterm = require "wezterm"

-- This table will hold the configuration.
local config = {}

-- No tab bar is needed, this is either done via Sway or tmux.
config.enable_tab_bar = false

-- Use the default monospace font at size 12.
config.font = wezterm.font "Fira Code"
config.font_size = 12.0

-- Return the configuration to wezterm.
return config
