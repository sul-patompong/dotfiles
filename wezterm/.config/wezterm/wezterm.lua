local wezterm = require("wezterm")
local config = {}

-- config.color_scheme = "Gruvbox Dark (Gogh)"
config.color_scheme = "Everforest Dark Hard (Gogh)"
config.font = wezterm.font("Iosevka Nerd Font")
config.font_size = 12

config.enable_tab_bar = false
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.8

return config
