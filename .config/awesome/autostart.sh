#!/bin/sh
function run {
  if ! pgrep -f "$1" > /dev/null ;
  then
    $@ &
  fi
}

run "setxkbmap latam"
run "touchpad_config --enable"
run "xset r rate 300 50"
run "xset -b"
run "mate-polkit"
run "picom -b"
run "redshift LAT:LON"
run "keepassxc-autostart"
