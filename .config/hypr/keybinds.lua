hl.bind(MAINMOD .. " + T", hl.dsp.exec_cmd(TERMINAL))
hl.bind(MAINMOD .. " + C", hl.dsp.window.close())
hl.bind(MAINMOD .. " + M", hl.dsp.exit())
hl.bind(MAINMOD .. " + E", hl.dsp.exec_cmd(FILEMANAGER))
hl.bind(MAINMOD .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(MAINMOD .. " + R", hl.dsp.exec_cmd(MENU .. " -show drun -theme /styles/drun.rasi"))
hl.bind(MAINMOD .. " + W", hl.dsp.exec_cmd(AWWW))
-- bind = $MAINMOD, P, pseudo, # dwindle
hl.bind(MAINMOD .. " + J", hl.dsp.layout("togglesplit, "))

-- Move focus with MAINMOD + arrow keys
-- bind = $MAINMOD, left, movefocus, l
-- bind = $MAINMOD, right, movefocus, r
hl.bind(MAINMOD .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(MAINMOD .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move to another monitor
hl.bind(MAINMOD .. " + left", hl.dsp.focus({ monitor = -1 }))
hl.bind(MAINMOD .. " + right", hl.dsp.focus({ monitor = "+1" }))

-- Move active window to other displays
hl.bind(MAINMOD .. " + SHIFT + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(MAINMOD .. " + SHIFT + right", hl.dsp.window.move({ direction = "right" }))

-- Standby shortcut
hl.bind(MAINMOD .. " + SHIFT + L", hl.dsp.exec_cmd(SCRIPTS .. "/standby-wayland.sh"))

-- Screenshot
hl.bind("CTRL + PRINT", hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"))

-- Rofi Clipboard
--TODO: Fix the images not being as wanted, make them bigger, make the text behind nog show, etc...
hl.bind(
	MAINMOD .. " + SHIFT + V",
	hl.dsp.exec_cmd(
		"cliphist list | "
			.. MENU
			.. ' -dmenu -theme ~/.config/rofi/styles/clipboard.rasi -p "󱘢" -display-columns 2 | cliphist decode | wl-copy'
	)
)
--bind = $MAINMOD SHIFT, V, exec, cliphist list | ~/.config/rofi/menus/cliphist-image-preview.sh | $menu -dmenu -theme ~/.config/rofi/styles/clipboard.rasi -p "󱘢" -display-columns 2 | cliphist decode | wl-copy

-- Audio control
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -p $(hyprctl activewindow -j | jq -r '.pid') -l 1 5%+"),
	{ repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume -p $(hyprctl activewindow -j | jq -r '.pid') -l 1 5%-"),
	{ repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute -p $(hyprctl activewindow -j | jq -r '.pid') toggle"))
hl.bind(MAINMOD .. " + XF86AudioMute", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ togle"))

-- Jellyfin Desktop specific
hl.bind(
	MAINMOD .. " + CTRL + SHIFT + left",
	hl.dsp.send_shortcut({ mods = "", key = "pageup", window = "stableid:18003c47" })
)
hl.bind(
	MAINMOD .. " + CTRL + SHIFT + right",
	hl.dsp.send_shortcut({ mods = "", key = "pagedown", window = "stableid:18003c47" })
)
--hl.bind(MAINMOD .. " + CTRL + SHIFT + left", hl.dsp.exec_cmd("playerctl -p JellyfinDesktop previous"))
--hl.bind(MAINMOD .. " + CTRL + SHIFT + right", hl.dsp.exec_cmd("playerctl -p JellyfinDesktop next"))
hl.bind(MAINMOD .. " + CTRL + ALT + SHIFT + J + D + P", hl.dsp.exec_cmd("playerctl -p JellyfinDesktop play-pause"))
--hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl -p JellyfinDesktop next"))

--# Added this so sony headset actually works with play-pause/next/previous
--hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl --ignore-player=firefox play-pause"), { locked = true })
--bindl =, XF86AudioNext, exec, playerctl --ignore-player=firefox next
--bindl =, XF86AudioPrev, exec, playerctl --ignore-player=firefox previous

-- Move/resize windows with MAINMOD + LMB/RMB and dragging
hl.bind(MAINMOD .. " + mouse:272", hl.dsp.window.drag())
hl.bind(MAINMOD .. " + mouse:273", hl.dsp.window.resize())

-- Fullscreen a window (mostly for games)
hl.bind(MAINMOD .. " + F", hl.dsp.window.fullscreen())

-- Unbind exit
-- TODO: manual review — 'unbind = $MAINMOD, M'. In Lua, capture the result of hl.bind(...) and call :remove(). See hl.meta.lua.
