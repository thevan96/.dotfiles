#!/usr/bin/env bash

picom &
caffeine &
nm-applet &
flameshot &
ibus-daemon &
~/.dropbox-dist/dropboxd &

xset r rate 200 80
xrdb -merge ~/.Xresources
feh --bg-scale ~/Dropbox/Pictures/Morskie\ Oko.jpg
xinput set-prop "Synaptics TM3096-001" "libinput Tapping Enabled" 1

# Lock
xautolock -time 10 -locker i3lock-fancy &
xss-lock --transfer-sleep-lock i3lock-fancy &
