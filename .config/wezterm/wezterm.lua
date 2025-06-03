local wezterm = require("wezterm")

local config = wezterm.config_builder()

config.font_size = 13.0
config.font = wezterm.font("Source Code Pro", { weight = "Medium" })
config.hide_tab_bar_if_only_one_tab = true
config.adjust_window_size_when_changing_font_size = false
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_decorations = "RESIZE"

config.keys = {}
if wezterm.target_triple:match("darwin$") then
	config.send_composed_key_when_left_alt_is_pressed = true

	local function use_cmd_as_meta(key)
		for _, mods in ipairs({ "", "|CTRL", "|SHIFT" }) do
			if mods == "" and (key == "c" or key == "v") then
				goto continue
			end
			table.insert(config.keys, {
				key = key,
				mods = "CMD" .. mods,
				action = wezterm.action.SendKey({
					key = key,
					mods = "OPT" .. mods,
				}),
			})
			::continue::
		end
	end

	for i = 0, 127 do
		local key = string.char(i)
		use_cmd_as_meta(key)
	end

	use_cmd_as_meta("LeftArrow")
	use_cmd_as_meta("RightArrow")
	use_cmd_as_meta("UpArrow")
	use_cmd_as_meta("DownArrow")

	table.insert(config.keys, {
		key = "Space",
		mods = "ALT",
		action = wezterm.action.SendKey({
			key = "Space",
			mods = "OPT",
		}),
	})
end

config.colors = {
	ansi = { "#3e4255", "#ea7183", "#96d382", "#ffcb6b", "#739df2", "#f2a7de", "#78cec1", "#a6b0d8" },
	brights = { "#505469", "#ea7183", "#96d382", "#ffcb6b", "#739df2", "#f2a7de", "#78cec1", "#959ec2" },
	background = "#1a1c2a",
	foreground = "#ffffff",
	cursor_bg = "#ffcb6b",
	cursor_fg = "#ffffff",
	selection_bg = "#505469",
	selection_fg = "#ffffff",
}

return config
