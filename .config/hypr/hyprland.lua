require("monitors")

-- See https://wiki.hyprland.org/Configuring/Keywords/ for more
require("vars")
require("env")
require("execs")
require("windowrules")
require("keybinds")
require("visuals")

-- Plugins
require("smw")

-- For all categories, see https://wiki.hyprland.org/Configuring/Variables/

hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1.0 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })
hl.animation({
	leaf = "global",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 5.39,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 4.79,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "windowsIn",
	enabled = true,
	speed = 4.1,
	bezier = "easeOutQuint",
	style = "popin 87%",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 1.49,
	bezier = "linear",
	style = "popin 87%",
})
hl.animation({
	leaf = "fadeIn",
	enabled = true,
	speed = 1.73,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeOut",
	enabled = true,
	speed = 1.46,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 3.03,
	bezier = "quick",
})
hl.animation({
	leaf = "layers",
	enabled = true,
	speed = 3.81,
	bezier = "easeOutQuint",
})
hl.animation({
	leaf = "layersIn",
	enabled = true,
	speed = 4,
	bezier = "easeOutQuint",
	style = "fade",
})
hl.animation({
	leaf = "layersOut",
	enabled = true,
	speed = 1.5,
	bezier = "linear",
	style = "fade",
})
hl.animation({
	leaf = "fadeLayersIn",
	enabled = true,
	speed = 1.79,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "fadeLayersOut",
	enabled = true,
	speed = 1.39,
	bezier = "almostLinear",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 1.94,
	bezier = "almostLinear",
	style = "fade",
})
hl.curve("myBezier", { type = "bezier", points = { { 0.05, 0.9 }, { 0.1, 1.05 } } })
hl.animation({
	leaf = "windows",
	enabled = true,
	speed = 7,
	bezier = "myBezier",
})
hl.animation({
	leaf = "windowsOut",
	enabled = true,
	speed = 7,
	bezier = "default",
	style = "popin 80%",
})
hl.animation({
	leaf = "border",
	enabled = true,
	speed = 10,
	bezier = "default",
})
hl.animation({
	leaf = "borderangle",
	enabled = true,
	speed = 8,
	bezier = "default",
})
hl.animation({
	leaf = "fade",
	enabled = true,
	speed = 7,
	bezier = "default",
})
hl.animation({
	leaf = "workspaces",
	enabled = true,
	speed = 6,
	bezier = "default",
})

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
	--	plugin = {
	--		split_monitor_workspaces = {
	--			count = 10,
	--		},
	--	},
})
