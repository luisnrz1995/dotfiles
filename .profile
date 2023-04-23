#!/bin/sh
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.local/bin/statusbar:$PATH"
setxkbmap latam &
touchpad_config -e 12 &
touchpad_config -e 16 &
mate-polkit &
xset r rate 300 50 &
pkill keepassxc-autos &
redshift LAT:LON &
