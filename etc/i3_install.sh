#!/usr/bin/env bash

sudo cp i3.desktop /usr/share/xsessions
sudo apt install i3 \
  i3lock-fancy \
  light \
  xss-lock \
  lxappearance \
  pavucontrol \
  picom \
  hsetroot

# Make caplocks to esc
# sudo vi /usr/share/X11/xkb/symbols/pc

sudo chmod +s $(which light)
