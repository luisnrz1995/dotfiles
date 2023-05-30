-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Show help
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")
-- Scratchpads
local scratch = require("utilities.scratch")
screen_width = awful.screen.focused().geometry.width
screen_height = awful.screen.focused().geometry.height

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, there were errors during startup!", text = awesome.startup_errors })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        if in_error then return end
        in_error = true
        naughty.notify({ preset = naughty.config.presets.critical, title = "Oops, an error happened!", text = tostring(err) })
        in_error = false
    end)
end
-- }}}

-- {{{ Function to toggle sticky
function toggle_sticky()
    local c = client.focus
    if c then
        c.sticky = not c.sticky
        c:emit_signal("property::sticky")
    end
end
---}}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_configuration_dir() .. "theme.lua")

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
terminal = "alacritty"
editor_cmd = os.getenv("EDITOR") or "nvim"
modkey = "Mod4"
-- }}}

-- {{{ Layouts
awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}

awful.layout.layouts[1].name, awful.layout.layouts[2].name, awful.layout.layouts[3].name = "[]=", "[M]=", "[floating]="

local function set_gap_values()
    local current_layout = awful.layout.getname(awful.layout.get(awful.screen.focused()))
    local new_useless_gap = current_layout == "[]=" and 1 or 0
    local new_gap_single_client = current_layout == "[]="

    local beautiful = beautiful
    if beautiful.useless_gap ~= new_useless_gap or beautiful.gap_single_client ~= new_gap_single_client then
        beautiful.useless_gap, beautiful.gap_single_client = new_useless_gap, new_gap_single_client
    end
end

set_gap_values()
tag.connect_signal("property::layout", set_gap_values)
-- }}}

-- {{{ Wallpaper
local function set_wallpaper(s)
    local wallpaper = type(beautiful.wallpaper) == "function" and beautiful.wallpaper(s) or beautiful.wallpaper
    gears.wallpaper.maximized(wallpaper, s, true)
end
--- }}}

-- {{{ Awesome menu
myawesomemenu = {
    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
    { "manual", terminal .. " -e man awesome" },
    { "edit config", editor_cmd .. " " .. awesome.conffile },
    { "restart", awesome.restart },
    { "quit", function() awesome.quit() end },
}
 
mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
                                     { "open terminal", terminal }
                                   }
                         })
mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon, menu = mymainmenu })
-- }}}

-- {{{ Screen
-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)

    -- Each screen has its own tag table.
    awful.tag({ " 1 ", " 2 ", " 3 ", " 4 ", " 5 ", " 6 ", " 7 ", " 8 ", " 9 " }, s, awful.layout.layouts[1])

    -- Create an imagebox widget which will contain an icon indicating which layout we're using.
    -- We need one layoutbox per screen.
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox.width = 50
    s.mylayoutbox.height = 17

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen  = s,
        filter  = awful.widget.taglist.filter.noempty,
        buttons = {
            awful.button({ }, 1, function(t) t:view_only() end),
            awful.button({ modkey }, 1, function(t)
                                            if client.focus then
                                                client.focus:move_to_tag(t)
                                            end
                                        end),
            awful.button({ }, 3, awful.tag.viewtoggle),
            awful.button({ modkey }, 3, function(t)
                                            if client.focus then
                                                client.focus:toggle_tag(t)
                                            end
                                        end),
            awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
            awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
        }
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen  = s,
        filter  = awful.widget.tasklist.filter.focused
    }
    beautiful.tasklist_plain_task_name = true
    beautiful.tasklist_disable_icon = true

    -- Network
    local network = awful.widget.watch(
        'sh -c "sb-network"', 1,
        function(widget, stdout)
         widget:set_text(stdout)
        end
    )

    -- Battery
    local battery = awful.widget.watch(
        'sh -c "sb-battery"', 1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- CPU
    local cpu = awful.widget.watch(
        'sh -c "sb-cpu"', 1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- Temperature
    local temperature = awful.widget.watch(
        'sh -c "sb-temperature"', 1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- Volume
    local volume = awful.widget.watch(
        'sh -c "sb-volume"', 0.1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- Brightness
    local brightness = awful.widget.watch(
        'sh -c "sb-brightness"', 0.1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- Clock
    local clock = awful.widget.watch(
        'sh -c "sb-clock"', 1,
        function(widget, stdout)
            widget:set_text(stdout)
        end
    )

    -- Separator
    local separator = wibox.widget.textbox()
    separator:set_text("|")

    -- Systray
    local systray = wibox.widget.systray()
    systray:set_base_size(16)
    beautiful.systray_icon_spacing = 4
    s.systray = wibox.widget.systray()
    s.systray.visible = false

    -- Create the wibox
    s.mywibox = awful.wibar({ position = "top", screen = s, height = 19 })

    -- Add widgets to the wibox
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        { -- Left widgets
            layout = wibox.layout.fixed.horizontal,
            s.mytaglist,
            wibox.container.margin(s.mylayoutbox, 3,3,0,0),
        },
            wibox.container.margin(s.mytasklist, 0,7,0,0),
        {
            layout = wibox.layout.fixed.horizontal,
            network,
            wibox.container.margin(separator, 5,5,2,1),
            battery,
            wibox.container.margin(separator, 5,5,2,1),
            cpu,
            wibox.container.margin(separator, 5,5,2,1),
            temperature,
            wibox.container.margin(separator, 5,5,2,1),
            volume,
            wibox.container.margin(separator, 5,5,2,1),
            brightness,
            wibox.container.margin(separator, 5,5,2,1),
            clock,
            wibox.container.margin(systray, 4,1,3,3),
        },
    }
end)
-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(
    awful.button({ }, 3, function () mymainmenu:toggle() end)
))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(
    -- Show help
    awful.key({ modkey }, "'",
        hotkeys_popup.show_help, { description="show help", group="awesome" }
    ),

    -- Move left/right between tags
    awful.key({ modkey }, "Left",
        awful.tag.viewprev, { description = "view previous", group = "tag" }
    ),
    awful.key({ modkey, }, "Right",
        awful.tag.viewnext, { description = "view next", group = "tag" }
    ),
    awful.key({ modkey }, "Tab",
        awful.tag.history.restore, { description = "go back", group = "tag" }
    ),

    -- Move between windows in current tag
    awful.key({ modkey }, "l", function ()
            awful.client.focus.byidx( 1)
        end,
        { description = "focus next by index", group = "client" }
    ),
    awful.key({ modkey }, "h", function ()
            awful.client.focus.byidx(-1)
        end,
        { description = "focus previous by index", group = "client" }
    ),

    -- Swap window position in current tag
    awful.key({ modkey, "Shift" }, "l", function ()
            awful.client.swap.byidx(  1)
        end,
        { description = "swap with next client by index", group = "client" }
    ),
    awful.key({ modkey, "Shift" }, "h", function ()
            awful.client.swap.byidx( -1)
        end,
        { description = "swap with previous client by index", group = "client" }
    ),

    -- Restart/exit awesome
    awful.key({ modkey, "Control" }, "r",
        awesome.restart, { description = "reload awesome", group = "awesome" }
    ),
    awful.key({ modkey, "Control"   }, "q",
        awesome.quit, { description = "quit awesome", group = "awesome" }
    ),

    -- Increase/decrease window size
    awful.key({ modkey, "Mod1" }, "l", function ()
            awful.tag.incmwfact( 0.05)
        end,
        { description = "increase window horizontally", group = "layout" }
    ),
    awful.key({ modkey, "Mod1" }, "h", function ()
            awful.tag.incmwfact(-0.05)
        end,
        { description = "decrease window horizontally", group = "layout" }
    ),
    awful.key({ modkey, "Mod1" }, "k", function ()
            awful.client.incwfact( 0.05)
        end,
        { description = "increase window vertically", group = "layout" }
    ),
    awful.key({ modkey, "Mod1" }, "j", function ()
            awful.client.incwfact(-0.05)
        end,
        { description = "decrease window vertically", group = "layout" }
    ),

    -- Changing layouts behavior
    awful.key({ modkey   }, "i", function ()
            awful.tag.incnmaster( 1, nil, true)
        end,
        { description = "increase the number of master clients", group = "layout" }
    ),
    awful.key({ modkey   }, "d", function ()
            awful.tag.incnmaster(-1, nil, true)
        end,
        { description = "decrease the number of master clients", group = "layout" }
    ),
    awful.key({ modkey, "Control" }, "d", function ()
            awful.tag.incncol( 1, nil, true)
        end,
        { description = "increase the number of columns", group = "layout" }
    ),
    awful.key({ modkey, "Control" }, "i", function ()
            awful.tag.incncol(-1, nil, true)
        end,
        { description = "decrease the number of columns", group = "layout" }
    ),

    -- Move between layouts
    awful.key({ modkey }, "space", function ()
            awful.layout.inc( 1)
        end,
        { description = "select next", group = "layout" }
    ),
    awful.key({ modkey, "Shift" }, "space", function ()
            awful.layout.inc(-1)
        end,
        { description = "select previous", group = "layout" }
    ),

    -- Toggle systray
    awful.key({ modkey, "Shift" }, "s", function ()
        awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible end,
        { description = "Toggle systray visibility", group = "toggle" }
    ),

    -- Launch applications
    awful.key({ modkey }, "Return", function ()
            awful.spawn.with_shell("alacritty")
        end,
        { description = "open a terminal", group = "launcher" }
    ),
    awful.key({ modkey }, "p", function ()
            awful.spawn.with_shell("dmenu_run -l 10 -i -p 'Run:'")
        end,
        { description = "run prompt launcher", group = "launcher" }
    ),
    awful.key({ modkey }, "b", function ()
            awful.spawn.with_shell("firefox-esr")
        end,
        { description = "open web browser", group = "launcher" }
    ),
    awful.key({ modkey }, "f", function ()
            awful.spawn.with_shell("pcmanfm")
        end,
        { description = "open file browser", group = "launcher" }
    ),

    -- Brightness control
    awful.key({}, "XF86MonBrightnessUp", function ()
            awful.spawn.with_shell("brightnessctl set +5%")
        end,
        { description = "increase brightness level", group = "brightness" }
    ),
    awful.key({}, "XF86MonBrightnessDown", function ()
            awful.spawn.with_shell("brightnessctl set 5%-")
        end,
        { description = "decrease brightness level", group = "brightness" }
    ),

    -- Volume control
    awful.key({}, "XF86AudioRaiseVolume", function ()
            awful.spawn.with_shell("pamixer -i 5")
        end,
        { description = "increase volume level", group = "volume" }
    ),
    awful.key({}, "XF86AudioLowerVolume", function ()
            awful.spawn.with_shell("pamixer -d 5")
        end,
        { description = "decrease volume level", group = "volume" }
    ),
    awful.key({}, "XF86AudioMute", function ()
            awful.spawn.with_shell("pamixer -t")
        end,
        { description = "mute volume", group = "volume" }
    ),

    -- Take screenshots
    awful.key({} , "Print", function ()
            awful.spawn.with_shell("screenshot")
        end,
        { description = "take screenshot", group = "screenshots" }
    ),
    awful.key({ modkey } , "Print", function ()
            awful.spawn.with_shell("screenshot --select")
        end,
        { description = "take screenshot of selected area", group = "screenshots" }
    ),
    awful.key({ "Mod1" } , "Print", function ()
            awful.spawn.with_shell("screenshot --window") 
        end,
        { description = "take screenshot of focused window", group = "screenshots" }
    ),

    -- Enable/disable reading mode (redshift)
    awful.key({ modkey }, "XF86MonBrightnessUp", function ()
        awful.spawn.with_shell("redshift LAT:LON")
        end,
        { description = "enable reading mode", group = "reading mode" }
    ),
    awful.key({ modkey }, "XF86MonBrightnessDown", function ()
            awful.spawn.with_shell("pkill redshift")
        end,
        { description = "disable reading mode", group = "reading mode" }
    ),

    -- Lock screen
    awful.key({ modkey }, "period", function ()
            awful.spawn.with_shell("slock") 
        end,
        { description = "lockscreen", group = "utilities" }
    ),

    -- Launch dmenu Script
    awful.key({ modkey, "Shift" }, "e", function ()
            awful.spawn.with_shell("dmemoji")
        end,
        { description = "dmenu emoji selector", group = "utilities" }
    ),
    awful.key({ modkey, "Shift" }, "k", function ()
            awful.spawn.with_shell("dmkill")
        end,
        { description = "dmenu process killer", group = "utilities" }
    ),     
    awful.key({ modkey, "Shift" }, "x", function ()
            awful.spawn.with_shell("dmpower")
        end,
        { description = "dmenu power menu", group = "utilities" }
    ),

    -- Scratchpads
    awful.key({ "Mod1", "Control" }, "t", function()
            scratch.toggle("alacritty --class spterm", { instance = "spterm" })
        end,
        { description = "Open scratchpad terminal", group = "scratchpads" }
    ),
    awful.key({ "Mod1", "Control" }, "h", function ()
            scratch.toggle("alacritty --class sphtop --title htop -e htop", { instance = "sphtop" })
        end,
        { description = "Open scratchpad htop", group = "scratchpads" }
    ),
    awful.key({ "Mod1", "Control" }, "r", function ()
            scratch.toggle("alacritty --class spranger --title ranger -e ranger", { instance = "spranger" })
        end,
        { description = "Open scratchpad ranger", group = "scratchpads" }
    )
)

clientkeys = gears.table.join(
    awful.key({ modkey }, "w", function (c)
            c:kill()
        end,
        { description = "close", group = "client" }
    ),

    awful.key({ modkey, "Shift" }, "f",
        awful.client.floating.toggle, { description = "toggle floating", group = "toggle" }
    ),

    awful.key({ modkey, "Control" }, "f", function(c)
            c.fullscreen = not c.fullscreen; c:raise()
        end,
        { description = "toggle fullscreen", group = "client" }
    ),

    awful.key({ modkey }, "s", function()
            toggle_sticky()
        end,
        {description = "Toggle Sticky", group = "client"}
    )

)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        -- View tag only.
        awful.key({ modkey }, "#" .. i + 9, function() awful.screen.focused().tags[i]:view_only() end,
            { description = "view tag #" .. i, group = "tag" }
        ),
        -- Move client to tag.
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function() local t = awful.screen.focused().tags[i] if client.focus and t then client.focus:move_to_tag(t) end end,
            { description = "move focused client to tag #" .. i, group = "tag" }
        )
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.move(c) end),
    awful.button({ modkey }, 3, function(c) c:emit_signal("request::activate", "mouse_click", {raise = true}) awful.mouse.client.resize(c) end)
)

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).
awful.rules.rules = {
    -- All clients will match this rule.
    {
        rule = {},
        properties = {
            border_width = beautiful.border_width,
            border_color = beautiful.border_normal,
            focus = awful.client.focus.filter,
            raise = true,
            keys = clientkeys,
            buttons = clientbuttons,
            screen = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.centered
        }
    },

    -- Floating clients.
    {
        rule_any = {
            instance = { "DTA", "copyq", "pinentry", "Browser", "Places"},
            class = { "Free Download Manager", "Gpick", "KeePassXC", "Connman-gtk" },
            name = { "Event Tester" },
            role = { "AlarmWindow", "ConfigManager", "pop-up" }
        },
        properties = { floating = true, placement = awful.placement.centered }
    },

    {
        rule_any = {
            instance = { "spterm", "sphtop", "spranger", },
            class = { "spterm", "sphtop", "spranger" }
        },
        properties = {
            skip_taskbar = false,
            floating = true,
            ontop = false,
            minimized = true,
            sticky = false,
            width = screen_width * 0.65,
            height = screen_height * 0.65
        },
        callback = function(c)
            awful.placement.centered(c, { honor_padding = true, honor_workarea = true })
            gears.timer.delayed_call(function() c.urgent = false end)
        end
    },

    -- Fix Firefox does not tiled.
    {
      rule = { class = "firefox" },
      properties = { tiled = true }
    },

    {
      rule = { instance = "Toolkit" },
      properties = { sticky = true, focus = false, placement = awful.placement.no_offscreen }
    } 
}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
-- }}}

-- Autostart.
awful.spawn.with_shell("~/.config/awesome/autostart.sh")
