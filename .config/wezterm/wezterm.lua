-- Pull in the wezterm API
local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.color_scheme = "Catppuccin Mocha"

config.font = wezterm.font("CaskaydiaCove NF", { weight = "Regular", style = "Italic" })
config.font_size = 12

config.window_decorations = "NONE"

config.leader = { key = "a", mods = "CTRL", timeout_milliseconds = 2000 }

config.keys = require("keybinds")
for i = 0, 9 do
	-- leader + number to activate that tab
	table.insert(config.keys, {
		key = tostring(i),
		mods = "LEADER",
		action = wezterm.action.ActivateTab(i),
	})
end

config.hide_tab_bar_if_only_one_tab = false
config.tab_bar_at_bottom = true
config.use_fancy_tab_bar = false
config.tab_and_split_indices_are_zero_based = true

return config
