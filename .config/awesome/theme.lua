local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font = "Fira Code 9.5"
theme.taglist_font = "FiraCode Nerd Font:size=9.5;0:antialias=true:autohint=true"

theme.bg_normal     = "#282828"
theme.bg_focus      = "#434C5E"
theme.bg_urgent     = "#EA6962"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#bbbbbb"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(1)
theme.border_normal = "#282828"
theme.border_focus  = "#434C5E"

theme.menu_height = dpi(15)
theme.menu_width  = dpi(130)

theme.wallpaper = "~/.local/share/backgrounds/003.jpg"

theme.icon_theme = nil

theme.awesome_icon = "/usr/share/awesome/icons/awesome16.png"

return theme
