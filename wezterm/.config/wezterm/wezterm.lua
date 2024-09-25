local wezterm = require("wezterm")
local config = {}

config.color_scheme = "Gruvbox Dark (Gogh)"
-- config.color_scheme = "Everforest Dark Hard (Gogh)"
config.font = wezterm.font("ZedMono Nerd Font Mono")
config.font_size = 17

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
-- config.window_background_opacity = 0.95

return config
