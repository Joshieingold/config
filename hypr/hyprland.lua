---------------
-- Variables --
---------------

local terminalApp = "alacritty"
local fileManagerApp = "thunar"
local menuApp = "noctalia msg panel-toggle launcher"
local mainMod = "SUPER"

--------------------
-- Initialization --
--------------------

hl.on("hyprland.start", function()
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("noctalia")
end)

-------------------
-- Monitor Setup --
-------------------

-- Vertical Right Monitor --
hl.monitor({
	output = "DP-1",
	mode = "1920x1080@60",
	position = "3840x0",
	scale = 1,
	transform = 1,
})
-- Middle Monitor --
hl.monitor({
	output = "HDMI-A-2",
	mode = "1920x1080@74.99",
	position = "1920x0",
	scale = 1,
})
-- Laptop Screen --
hl.monitor({
	output = "eDP-1",
	mode = "1920x1080@60",
	position = "0x0",
	scale = 1,
})

-------------------
-- Look and Feel --
-------------------

hl.config({
	general = {
		gaps_in = 3,
		gaps_out = 10,
		border_size = 2,
		col = {
			active_border = { colors = { "rgba(33ccffee)", "rgba(00ff99ee)" }, angle = 45 },
			inactive_border = "rgba(595959aa)",
		},
		resize_on_border = true,
		allow_tearing = false,
		layout = "dwindle",
	},
	decoration = {
		rounding = 5,
		rounding_power = 5,
		active_opacity = 1.0,
		inactive_opacity = 1.0,
		shadow = {
			enabled = true,
			range = 4,
			render_power = 3,
			color = 0xee1a1a1a,
		},
		blur = {
			enabled = true,
			size = 4,
			passes = 2,
			vibrancy = 0.1696,
		},
	},
	animations = {
		enabled = true,
	},
})

-- Animation Creation --
hl.curve("default", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1.0 } } })
hl.curve("wind", { type = "bezier", points = { { 0.12, 0.92 }, { 0.08, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.18, 0.95 }, { 0.22, 1.03 } } })
hl.curve("liner", { type = "bezier", points = { { 1, 1 }, { 1, 1 } } })

-- Animation Mapping --
hl.animation({ leaf = "windows", enabled = true, speed = 5, bezier = "wind", style = "popin 60%" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 6, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 4, bezier = "overshot", style = "popin 60%" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 4, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers", enabled = true, speed = 4, bezier = "default", style = "popin" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeSwitch", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeShadow", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeDim", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "fadeLayers", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 5, bezier = "overshot", style = "slidevert" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "liner" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 24, bezier = "liner", style = "loop" })

-- Layouts --
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({

	master = {
		new_status = "master",
	},
})
hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

-- Wallpaper --
hl.config({
	misc = {
		force_default_wallpaper = 0,
		disable_hyprland_logo = false,
	},
})

------------
-- Inputs --
------------

hl.config({
	input = {
		kb_layout = "us",
		kb_variant = "",
		kb_model = "",
		kb_options = "",
		kb_rules = "",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = {
			natural_scroll = true,
		},
	},
})

hl.gesture({
	fingers = 3,
	direction = "horizontal",
	action = "workspace",
})

hl.device({
	name = "DeathAdder",
	sensitivity = -0.4,
})

--------------
-- Keybinds --
--------------

-- Open Apps --
hl.bind(mainMod .. " + return", hl.dsp.exec_cmd(terminalApp)) -- Open Terminal
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManagerApp)) -- Open FileManager
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(menuApp)) -- Open Search
hl.bind(mainMod .. " + Q", hl.dsp.window.close()) -- Kill App

-- Layout Management --
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

-- Move Cursor With Keys --
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" })) -- Vim Bind

hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" })) -- Vim Bind

hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workplace Switching --
for i = 1, 10 do
	local key = i % 10
	if i == 2 then
		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = 3 }))
		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = 3 }))
	elseif i == 3 then
		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = 2 }))
		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = 2 }))
	else
		hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
		hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
	end
end

-- Scroll through Workplaces --
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- drag and resize --
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

------------------
-- SPECIAL KEYS --
------------------
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Requires playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

------------------
-- Window Rules --
------------------

local suppressMaximizeRule = hl.window_rule({
	-- Ignore maximize requests from all apps. You'll probably like this.
	name = "suppress-maximize-events",
	match = { class = ".*" },

	suppress_event = "maximize",
})
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},

	no_focus = true,
})
hl.window_rule({
	name = "move-hyprland-run",
	match = { class = "hyprland-run" },

	move = "20 monitor_h-120",
	float = true,
})

require("./noctalia.lua")

-- For Noctalia Color templates
require("noctalia").apply_theme()
