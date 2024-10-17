local wez = require("wezterm")

-- This will hold the configuration.
local config = wez.config_builder()

config.color_scheme = "Tokyo Night Moon"

config.font_size = 16
config.font = wez.font_with_fallback({
  { family = "CaskaydiaCove Nerd Font Propo", weight = "Regular" },
  "Noto Sans Canadian Aboriginal",
  "DejaVu Serif",
  "Noto Sans CJK SC",
  "FiraCode",
})

-- Fix the issue of render characters as block
config.front_end = "WebGpu"

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.7

config.window_decorations = "NONE"

return config
