package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

smw.setup({
	workspace_count = 10,
})

for i = 1, smw.get_amount_of_workspaces() do
	local n = tostring(i)
	if n == "10" then
		n = "0"
	end -- Optional if you configured 10 workspaces: bind workspace 10 to SUPER + 0
	-- Switch to the Nth workspace on the currently focused monitor.
	hl.bind(MAINMOD .. " +" .. n, smw.workspace(n))
	-- Move the active window to the Nth workspace on the currently focused monitor silently (no focus change).
	hl.bind(MAINMOD .. " + SHIFT +" .. n, smw.move_to_workspace(n))
end

-- Switch workspaces on focused screen with MAINMOD + [0-9]
hl.bind(MAINMOD .. " + 1", smw.workspace(1))
hl.bind(MAINMOD .. " + 2", smw.workspace(2))
hl.bind(MAINMOD .. " + 4", smw.workspace(4))
hl.bind(MAINMOD .. " + 5", smw.workspace(5))
hl.bind(MAINMOD .. " + 6", smw.workspace(6))
hl.bind(MAINMOD .. " + 7", smw.workspace(7))
hl.bind(MAINMOD .. " + 8", smw.workspace(8))
hl.bind(MAINMOD .. " + 9", smw.workspace(9))
hl.bind(MAINMOD .. " + 0", smw.workspace(10))

-- Move active window to a workspace on current screen with MAINMOD + SHIFT + [0-9]
hl.bind(MAINMOD .. " + SHIFT + 1", smw.move_to_workspace(1))
hl.bind(MAINMOD .. " + SHIFT + 2", smw.move_to_workspace(2))
hl.bind(MAINMOD .. " + SHIFT + 4", smw.move_to_workspace(4))
hl.bind(MAINMOD .. " + SHIFT + 5", smw.move_to_workspace(5))
hl.bind(MAINMOD .. " + SHIFT + 6", smw.move_to_workspace(6))
hl.bind(MAINMOD .. " + SHIFT + 7", smw.move_to_workspace(7))
hl.bind(MAINMOD .. " + SHIFT + 8", smw.move_to_workspace(8))
hl.bind(MAINMOD .. " + SHIFT + 9", smw.move_to_workspace(9))
hl.bind(MAINMOD .. " + SHIFT + 0", smw.move_to_workspace(10))
