local wez = require("wezterm")

-- This will hold the configuration.
local config = wez.config_builder()

config.color_scheme = "Tokyo Night Moon"

config.font_size = 15
config.font = wez.font_with_fallback({
	{ family = "CaskaydiaCove Nerd Font Propo", weight = "Regular", harfbuzz_features = { "ss01" } },
	"FiraCode",
	"Noto Sans Mono CJK SC",
})

config.use_fancy_tab_bar = false
config.hide_tab_bar_if_only_one_tab = true
config.window_background_opacity = 0.9

config.window_decorations = "NONE"

return config
