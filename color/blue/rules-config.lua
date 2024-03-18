-----------------------------------------------------------------------------------------------------------------------
--                                                Rules config                                                       --
-----------------------------------------------------------------------------------------------------------------------

-- Grab environment
local awful =require("awful")
local beautiful = require("beautiful")
local redtitle = require("redflat.titlebar")

-- Initialize tables and vars for the module
-----------------------------------------------------------------------------------------------------------------------
local rules = {}

rules.base_properties = {
	border_width     = beautiful.border_width,
	border_color     = beautiful.border_normal,
	focus            = awful.client.focus.filter,
	raise            = true,
	size_hints_honor = false,
	screen           = awful.screen.preferred,
}

rules.floating_any = {
	class = {
		"Clipflap", "Run.py", "Rofi"
	},
	role = { "AlarmWindow", "pop-up", },
	type = { "dialog" }
}

rules.titlebar_exceptions = {
	class = { "Cavalcade", "Clipflap", "Steam", "Qemu-system-x86_64" }
}

rules.maximized = {
	class = { "Emacs", "Alacritty", "Element" }
}

-- Build rule table
-----------------------------------------------------------------------------------------------------------------------
function rules:init(args)

	args = args or {}
	self.base_properties.keys = args.hotkeys.keys.client
	self.base_properties.buttons = args.hotkeys.mouse.client
	self.taglist = args.taglist
	self.env = args.env or {}


	-- Build rules
	--------------------------------------------------------------------------------
	self.rules = {
		{
			rule       = {},
			properties = args.base_properties or self.base_properties
		},
		{
			rule_any   = args.floating_any or self.floating_any,
			properties = { floating = true }
		},
		{
			rule_any   = self.maximized,
			callback = function(c)
				c.maximized = true
				redtitle.cut_all({ c })
				c.height = c.screen.workarea.height - 2 * c.border_width
			end
		},
		{
			rule_any   = { type = { "normal", "dialog" }},
			except_any = self.titlebar_exceptions,
			properties = { titlebars_enabled = true }
		},
		{
			rule_any   = { type = { "normal" }},
			properties = { placement = awful.placement.no_overlap + awful.placement.no_offscreen }
		},
		{
			rule = { class = "firefox" },
			properties = { screen = screen_primary, tag = self.taglist[1] }
		},
		{
			rule = { class = "qutebrowser" },
			properties = { screen = screen_primary, tag = self.taglist[1] }
		},
		{
			rule = { class = "Google-chrome" },
			properties = { screen = screen_primary, tag = self.taglist[1] }
		},
		{
			rule = { class = "vivaldi-stable" },
			properties = { screen = screen_primary, tag = self.taglist[1, 9] }
		},
		{
			rule = { class = "Emacs" },
			properties = { screen = screen_primary, tag = self.taglist[3] }
		},
		{
			rule = { class = "URxvt" },
			properties = { screen = screen_primary, tag = self.taglist[2] }
		},
		{
			rule = { class = "Alacritty" },
			properties = { screen = screen_primary, tag = self.taglist[2] }
		},
		{
			rule = { class = "Slack" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "discord" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "Element" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "Rocket.Chat" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "zoom" },
			properties = { screen = screen_secondary, tag = self.taglist[7] }
		},
		{
			rule = { class = "TelegramDesktop" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "Thunderbird" },
			properties = { screen = screen_secondary, tag = self.taglist[4] }
		},
		{
			rule = { class = "polar-bookshelf" },
			properties = { screen = screen_primary, tag = self.taglist[6] }
		},
		{
			rule = { class = "obsidian" },
			properties = { screen = screen_primary, tag = self.taglist[6] }
		},
		{
			rule = { class = "Pcmanfm" },
			properties = { screen = screen_primary, tag = self.taglist[7] }
		},
		{
			rule = { class = "Thunar" },
			properties = { screen = screen_primary, tag = self.taglist[7] }
		},
		{
			rule = { class = "Zeal" },
			properties = { screen = screen_primary, tag = self.taglist[3] }
		},
		{
			rule = { class = "Ledger Live" },
			properties = { screen = screen_secondary, tag = self.taglist[8] }
		},
		{
			rule = { class = "mpv" },
			properties = { floating = true }
		},
		{
			rule = { class = "gnome-calculator" },
			properties = { floating = true }
		},
		{
			rule = { class = "deepin-calculator" },
			properties = { floating = true }
		},
		{
			rule = { class = "dde-calendar" },
			properties = { floating = true }
		},
		-- Tags placement
		{
			rule = { instance = "Xephyr" },
			properties = { tag = self.env.theme == "ruby" and "Test" or "Free", fullscreen = true }
		},

		-- Jetbrains splash screen fix
		{
			rule_any = { class = { "jetbrains-%w+", "java-lang-Thread" } },
			callback = function(jetbrains)
				if jetbrains.skip_taskbar then jetbrains.floating = true end
			end
		}
	}


	-- Set rules
	--------------------------------------------------------------------------------
	awful.rules.rules = rules.rules
end

-- End
-----------------------------------------------------------------------------------------------------------------------
return rules
