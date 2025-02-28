-- +----------------------------+
-- | WezTerm Configuration file |
-- +----------------------------+

local wezterm = require("wezterm")

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

local function load_font(font)
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

wezterm.on("open-uri", function(window, pane, uri)
	wezterm.log_info("Opening URI: " .. uri)
	wezterm.run_child_process({ "start", uri })
end)

return {
	-- Window, layout
	window_padding = {
		left = pad,
		right = pad,
		top = pad,
		bottom = pad,
	},

	enable_kitty_keyboard = false,
	term = "xterm-256color",

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
		border_left_width = "2px",
		border_right_width = "2px",
		border_bottom_height = "2px",
		border_top_height = "2px",
		-- "#98971a",
		-- "#FF8C00"
		border_left_color = "#777779",
		border_right_color = "#777779", -- #d3869b
		border_top_color = "#777779", -- #fabd2f
		border_bottom_color = "#777779", -- #83a598
	},

	hide_tab_bar_if_only_one_tab = true,
	enable_wayland = true,
	initial_cols = 150,
	initial_rows = 50,

	-- Fonts
	font = load_font(font_normal),
	font_size = 18,
	font_rules = {
		{
			italic = true,
			font = load_font(font_italic),
		},
	},

	-- Cursor
	-- (block, beam, underline)
	default_cursor_style = "SteadyBlock", -- others: "Beam", "Underline"
	cursor_blink_rate = 500, -- (ms)
	cursor_thickness = 2,
	cursor_blink_ease_in = "Linear", -- "Linear", "ease_in", "ease_out", ...
	cursor_blink_ease_out = "Linear",

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

	-- Mouse
	-- Enable smooth scrolling
	-- use_scroll_to_scroll = true, -- Enable mouse-based scrolling
	-- mouse_wheel_scroll_speed = 3, -- Adjust scroll speed
	-- mouse_wheel_scroll_method = "smooth", -- "smooth", "adaptive", "default"
	scrollback_lines = 10000,

	-- Open links
	hyperlink_rules = {
		-- Recognize HTTP/HTTPS links
		{
			regex = [[\bhttps?://[^\s]+]],
			format = "$0",
		},
		-- Recognize GitHub/GitLab links
		{
			regex = [[\b(?:github|gitlab)\.com/[^\s]+]],
			format = "https://$0",
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
	},

	-- shell
	-- default_prog = { "/opt/homebrew/bin/fish" },

	adjust_window_size_when_changing_font_size = true,
	tab_bar_at_bottom = true,
	-- enable_osc52_copy = true,

	-- disable_alternate_screen_buffer = true,
	-- scrollback_lines = 3500,
	-- use_scroll_to_scroll = true,
}
