require("monitors")

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
require("vars")
require("env")
require("execs")
require("windowrules")
require("keybinds")
require("visuals")
require("animations")

-- Plugins
require("smw")

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/

hl.workspace_rule({
	workspace = "false",
})

hl.config({
	ecosystem = {
		no_update_news = true,
		no_donation_nag = true,
	},
	input = {
		kb_layout = "eu,jp",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		touchpad = {
			natural_scroll = false,
		},
		accel_profile = "flat",
		sensitivity = 0, -- -1.0 - 1.0, 0 means no modification.
	},
	render = {
		cm_auto_hdr = 2,
	},
	general = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		gaps_in = 3,
		gaps_out = 5,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		-- Set to true enable resizing windows by clicking and dragging on borders and gaps
		resize_on_border = false,
		-- Please see https://wiki.hyprland.org/Configuring/Tearing/ before you turn this on
		allow_tearing = true,
		layout = "dwindle",
	},
	decoration = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		rounding = 10,
		-- Change transparency of focused and unfocused windows
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		blur = {
			enabled = true,
			size = 3,
			passes = 1,
			vibrancy = 0.1696,
		},
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = "rgba(1a1a1aee)",
		},
	},
	animations = {
		enabled = true,
		-- Some default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
		-- Default animations, see https://wiki.hyprland.org/Configuring/Animations/ for more
	},
	dwindle = {
		-- See https://wiki.hyprland.org/Configuring/Dwindle-Layout/ for more
		preserve_split = true, -- you probably want this
	},
	master = {
		-- See https://wiki.hyprland.org/Configuring/Master-Layout/ for more
		new_status = "master",
	},
	misc = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
		force_default_wallpaper = 0, -- Set to 0 or 1 to disable the anime mascot wallpapers
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
		vrr = 1,
		initial_workspace_tracking = 0,
		font_family = FONTMONO,
	},
	gestures = {
		-- See https://wiki.hyprland.org/Configuring/Variables/ for more
	},
	xwayland = {
		force_zero_scaling = true,
	},
	opengl = {
		nvidia_anti_flicker = false,
	},
	cursor = {
		no_hardware_cursors = true,
	},
})
