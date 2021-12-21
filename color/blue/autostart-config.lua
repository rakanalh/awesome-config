-----------------------------------------------------------------------------------------------------------------------
--                                              Autostart app list                                                   --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful = require("awful")

-- Initialize tables and vars for module
-----------------------------------------------------------------------------------------------------------------------
local autostart = {}

-- Application list function
--------------------------------------------------------------------------------
function autostart.run()
	-- firefox sync
	-- awful.spawn.with_shell("python ~/scripts/firefox/ff-sync.py")

	-- utils
	awful.spawn.with_shell("unclutter -root")
	awful.spawn.with_shell("greenclip daemon")
	-- awful.spawn.with_shell("compton")
	awful.spawn.with_shell("udiskie")
	awful.spawn.with_shell("mpd")
	awful.spawn.with_shell("mpDris2")
	awful.spawn.with_shell("nm-applet")

	-- apps
	awful.spawn.with_shell("firefox")
	awful.spawn.with_shell("emacs")
	awful.spawn.with_shell("alacritty")
	awful.spawn.with_shell("element-desktop")
	awful.spawn.with_shell("slack")
	awful.spawn.with_shell("telegram-desktop")
end

-- Read and commads from file and spawn them
--------------------------------------------------------------------------------
function autostart.run_from_file(file_)
	local f = io.open(file_)
	for line in f:lines() do
		if line:sub(1, 1) ~= "#" then awful.spawn.with_shell(line) end
	end
	f:close()
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return autostart
