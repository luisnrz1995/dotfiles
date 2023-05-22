#!/bin/sh
xset r rate 300 50 &
nitrogen --restore & # set wallpaper.
xset r rate 300 50 & # set keyboard repeat delay and rate.
touchpad_config -e 11 &
# picom &
redshift LAT:LON &
mate-polkit &
keepassxc-autostart &
pkill keepassxc-autos &
