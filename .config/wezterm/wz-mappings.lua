---@type Wezterm
local wezterm = require("wezterm")
---@type Action
local wa = wezterm.action

local keys = {
	-- Pane related keys
	{ key = "|", mods = "ALT", action = wa.SplitHorizontal({ args = { "/bin/zsh" } }) },
	{ key = "'", mods = "ALT", action = wa.SplitVertical({ args = { "/bin/zsh" } }) },
	{ key = "{", mods = "ALT", action = wa.ActivatePaneDirection("Left") },
	{ key = "}", mods = "ALT", action = wa.ActivatePaneDirection("Right") },
	{ key = "+", mods = "ALT", action = wa.ActivatePaneDirection("Up") },
	{ key = "-", mods = "ALT", action = wa.ActivatePaneDirection("Down") },
	{ key = "n", mods = "CMD|ALT", action = wa.AdjustPaneSize({ "Left", 1 }) },
	{ key = "-", mods = "CMD|ALT", action = wa.AdjustPaneSize({ "Down", 1 }) },
	{ key = ",", mods = "CMD|ALT", action = wa.AdjustPaneSize({ "Up", 1 }) },
	{ key = "m", mods = "CMD|ALT", action = wa.AdjustPaneSize({ "Right", 1 }) },
	{ key = "c", mods = "ALT", action = wa.CloseCurrentPane({ confirm = true }) },
	-- Tab related keys
	{ key = "x", mods = "CMD|ALT", action = wa.CloseCurrentTab({ confirm = true }) },
	{ key = "t", mods = "ALT", action = wa.SpawnTab("CurrentPaneDomain") },
	-- Tab navigation
	{ key = "Tab", mods = "CMD", action = wa.ActivateTabRelative(-1) },
	{ key = "Tab", mods = "CMD|SHIFT", action = wa.ActivateTabRelative(1) },
	-- Miscellaneous
	{ key = "Enter", mods = "CMD|CTRL", action = wa.ToggleFullScreen },
	{ key = "+", mods = "CMD", action = wa.IncreaseFontSize },
	{ key = "-", mods = "CMD", action = wa.DecreaseFontSize },
	-- Utilities
	{ key = "c", mods = "CMD", action = wa.CopyTo("Clipboard") },
	{ key = "v", mods = "CMD", action = wa.PasteFrom("Clipboard") },
	-- Debugging and core functionality
	{ key = "d", mods = "CMD|ALT", action = wa.ShowDebugOverlay },
	{ key = "p", mods = "CMD|SHIFT", action = wa.ActivateCommandPalette },
}

return keys
