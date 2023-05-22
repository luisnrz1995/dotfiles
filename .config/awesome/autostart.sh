#!/bin/sh
setxkbmap latam
touchpad_config -e 11
xset r rate 300 50
pgrep -x redshift > /dev/null || redshift LAT:LON &
pgrep -x keepassxc > /dev/null || keepassxc-autostart &
pkill keepassxc-autos &
sleep 5; pkill autostart.sh &
