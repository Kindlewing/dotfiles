local wezterm = require 'wezterm'
local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

config.color_scheme = 'Catppuccin Mocha'
config.enable_tab_bar = false
config.font_size = 10.0

config.window_background_opacity = 0.8
config.window_decorations = 'RESIZE'
config.keys = {
	{
		key = 'f',
		mods = 'CTRL',
		action = wezterm.action.ToggleFullScreen,
	}
}
config.mouse_bindings = {
	-- Ctrl-click will open the link under the mouse cursor
	{
		event = { Up = { streak = 1, button = 'Left' } },
		mods = 'CTRL',
		action = wezterm.action.OpenLinkAtMouseCursor,
	}
}
return config
