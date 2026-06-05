hl.on("hyprland.start", function()
	hl.exec_cmd("waybar & swaync & hypridle & awww-daemon")
	hl.exec_cmd("hyprpm reload -n")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("systemctl --user start hyprpolkitagent")
	hl.exec_cmd("fcitx5")
	hl.exec_cmd("firefox & steam & thunderbird & slack --ozone-platform=wayland & signal-desktop")
	hl.exec_cmd(
		"sleep 10; vesktop --ozone-platform=wayland & jellyfin-desktop --platform wayland-egl & lact & /mnt/crucial-ssd/SAN/san.AppImage"
	)
	hl.exec_cmd("wljoywake -t 10")
end)
