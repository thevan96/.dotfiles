#!/usr/bin/env bash

xset r rate 200 80 &

# hsetroot -solid #000 &
hsetroot -cover ~/Dropbox/Pictures/lockscreen1366x768.png

xrdb -merge ~/.Xresources &
xrandr --output eDP-1 --mode 1366x768 &

xinput set-prop "Synaptics TM3096-001" "libinput Tapping Enabled" 1 &
/usr/bin/gnome-keyring-daemon --start --components=ssh,secrets,pkcs11 &

nm-applet &
pasystray &
picom &
ibus-daemon -drxR &

# Dropbox
~/.local/bin/run_dropbox.sh &
