#!/usr/bin/env bash

xset r rate 200 80
xrdb -merge ~/.Xresources
feh --bg-scale ~/Dropbox/Pictures/Morskie\ Oko.jpg
xinput set-prop "Synaptics TM3096-001" "libinput Tapping Enabled" 1
autorandr --change &

caffeine &
nm-applet &
ibus-daemon -drxR &
picom --vsync &

~/.local/bin/run_dropbox.sh &

# Remap caplock to esc
# sudo vi /usr/share/X11/xkb/symbols/pc
# ~/.local/bin/caplock_to_esc.sh &
