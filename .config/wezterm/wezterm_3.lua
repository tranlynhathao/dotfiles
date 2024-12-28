-- +----------------------------+
-- | WezTerm Configuration file |
-- +----------------------------+

local wezterm = require("wezterm")
local state_file = os.getenv("HOME") .. "/.wezterm_state"
local state = {}

local status, wezterm = pcall(require, "wezterm")
if not status then
	print("Unable to load wezterm module")
end

local pad = 0

local font_normal = {
	family = "FiraCode Nerd Font",
	weight = "Regular",
	italic = false,
}

local font_italic = {
	family = "VictorMono Nerd Font",
	weight = "DemiBold",
	italic = true,
}

function load_font(font)
	return wezterm.font(font.family, {
		weight = font.weight,
		italic = font.italic,
	})
end

wezterm.on("window-focus-changed", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	overrides.colors = {
		background = "rgba(40, 40, 40, 0.9)",
	}
	window:set_config_overrides(overrides)
end)

wezterm.on("update-right-status", function(window, pane)
	local tabs = window:tabs() -- Get tab category
	local tab_count = #tabs -- Count number of tabs
	local current_tab = window:active_tab() -- Running tab
	local current_index = current_tab and current_tab:index() or 0 -- Current tab index (0-based)
	local tab_info = string.format("Tabs: %d | Current: %d", tab_count, current_index + 1) -- Show information
	window:set_right_status(tab_info)
end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local index = tab.tab_index + 1
	local cwd = tab.active_pane.current_working_dir:match("[^/]+$") or ""
	local process = tab.active_pane.foreground_process_name or ""
	return {
		{ Text = string.format(" %d: %s (%s) ", index, cwd, process) },
	}
end)

wezterm.on("window-config-reloaded", function(window, pane)
	local tabs = window:tabs()
	local state = {}
	for _, tab in ipairs(tabs) do
		local panes = tab:panes()
		local tab_state = {}
		for _, p in ipairs(panes) do
			table.insert(tab_state, {
				cwd = p:get_current_working_dir(),
				process = p:get_foreground_process_name(),
			})
		end
		table.insert(state, tab_state)
	end
	local state_file = os.getenv("HOME") .. "/.wezterm_state"
	local f = io.open(state_file, "w")
	if f then
		f:write(wezterm.json_encode(state))
		f:close()
	end
end)

local f = io.open(state_file, "r")
if f then
	local contents = f:read("*a")
	state = wezterm.json_decode(contents) or {}
	f:close()
end

wezterm.on("gui-startup", function(cmd)
	if #state > 0 then
		for _, tab_state in ipairs(state) do
			for _, pane_state in ipairs(tab_state) do
				wezterm.spawn({
					cwd = pane_state.cwd,
					args = { pane_state.process or wezterm.default_prog },
				})
			end
		end
	end
end)

return {
	-- Window, layout
	window_padding = {
		left = pad,
		right = pad,
		top = pad,
		bottom = pad,
	},

	-- addition
	-- enable_tab_bar = false,
	macos_window_background_blur = 10,
	window_decorations = "RESIZE",
	window_background_opacity = 0.8,

	-- window_frame = {
	-- 	active_titlebar_bg = "#3c3836",
	-- 	inactive_titlebar_bg = "#3c3836",
	-- },

	-- tab bar transparent
	window_frame = {
		active_titlebar_bg = "rgba(40, 40, 40, 0.5)", -- transparent
		inactive_titlebar_bg = "rgba(40, 40, 40, 0.5)",
	},
	hide_tab_bar_if_only_one_tab = true,
	enable_wayland = true,
	initial_cols = 100,
	initial_rows = 40,

	-- Fonts
	font = load_font(font_normal),
	font_size = 18,
	font_rules = {
		{
			italic = true,
			font = load_font(font_italic),
		},
	},

	-- Colors
	color_scheme = "gruvbox",
	color_schemes = {
		gruvbox = {
			foreground = "#ebdbb2",
			background = "#282828",
			cursor_bg = "#928374",
			cursor_border = "#ebdbb2",
			cursor_fg = "#282828",
			selection_bg = "#ebdbb2",
			selection_fg = "#3c3836",

			ansi = {
				"#282828", -- black
				"#cc241d", -- red
				"#98971a", -- green
				"#d79921", -- yellow
				"#458588", -- blue
				"#b16286", -- purple
				"#689d6a", -- aqua
				"#ebdbb2", -- white
			},

			brights = {
				"#928374", -- black
				"#fb4934", -- red
				"#b8bb26", -- green
				"#fabd2f", -- yellow
				"#83a598", -- blue
				"#d3869b", -- purple
				"#8ec07c", -- aqua
				"#fbf1c7", -- white
			},
		},
	},

	-- Keybinds
	keys = {
		{
			key = "h",
			mods = "CTRL | SHIFT",
			-- Previous tab
			action = wezterm.action({ ActivateTabRelative = -1 }),
		},
		{
			key = "l",
			mods = "CTRL | SHIFT",
			-- Next tab
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			key = "j",
			mods = "CTRL | SHIFT",
			-- Scroll down
			action = wezterm.action({ ScrollByLine = 1 }),
		},
		{
			key = "k",
			mods = "CTRL | SHIFT",
			-- Scroll up
			action = wezterm.action({ ScrollByLine = -1 }),
		},
		{
			key = "t",
			mods = "CTRL | SHIFT",
			-- Show Info Tab
			action = wezterm.action.ShowTabNavigator,
		},
		{
			key = "p",
			mods = "CTRL | SHIFT",
			action = wezterm.action.PaneSelect, -- Chọn pane
		},
	},

	-- shell
	-- default_prog = { "/opt/homebrew/bin/fish" },
	default_prog = { "/opt/homebrew/bin/tmux", "new-session", "-A", "-s", "default" },

	adjust_window_size_when_changing_font_size = true,
	-- enable_osc52_copy = true,
}
