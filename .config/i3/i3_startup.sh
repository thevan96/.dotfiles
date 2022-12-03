#!/usr/bin/env bash

xset r rate 200 80&
autorandr --change&
xrdb -merge ~/.Xresources&

# hsetroot -solid #000&
feh --bg-scale ~/Dropbox/Pictures/matrix.png

xinput set-prop "Synaptics TM3096-001" "libinput Tapping Enabled" 1&
/usr/bin/gnome-keyring-daemon --start --components=ssh,secrets,pkcs11&

nm-applet&
ibus-daemon -drxR&
picom&
flameshot&

# Dropbox
~/.local/bin/run_dropbox.sh&
