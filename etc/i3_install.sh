#!/usr/bin/env bash

sudo apt install i3 \
  keychain \
  i3lock-fancy \
  light \
  xss-lock \
  lxappearance \
  pavucontrol \
  picom \
  pasystray \
  hsetroot

# Make caplocks to esc
# sudo vi /usr/share/X11/xkb/symbols/pc

sudo chmod +s $(which light)
