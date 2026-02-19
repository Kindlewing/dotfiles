-- Pull in the wezterm API
local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.keys = require("lua.keybinds")
config.color_scheme = "Everforest Dark Hard (Gogh)"

config.font = wezterm.font("CaskaydiaCoveNF Nerd Font", { weight = "Regular", style = "Italic" })
config.font_size = 11

config.window_decorations = "NONE"
config.window_close_confirmation = "NeverPrompt"
config.window_background_opacity = 1
config.text_background_opacity = 1.0
config.default_cursor_style = "SteadyBlock"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.colors = {
	cursor_bg = "#ffffff",
	cursor_fg = "#000000",
	cursor_border = "#ffffff",
}

config.hide_tab_bar_if_only_one_tab = false
config.hide_mouse_cursor_when_typing = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.warn_about_missing_glyphs = false
config.exit_behavior_messaging = "Verbose"
config.tab_and_split_indices_are_zero_based = true

return config
