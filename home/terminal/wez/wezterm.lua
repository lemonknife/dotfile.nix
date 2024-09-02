local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

config.color_scheme = 'Tokyo Night Moon';

config.default_prog = { '/usr/local/bin/fish', '-l' }

return config
