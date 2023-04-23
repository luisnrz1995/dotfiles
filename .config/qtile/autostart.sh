#!/bin/sh
nitrogen --restore & # set wallpaper.
xset r rate 300 50 & # set keyboard repeat delay and rate.
picom &
pgrep -x panel > /dev/null &
