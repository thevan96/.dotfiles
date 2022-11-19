#!/usr/bin/env bash

sudo apt install i3 \
  lxappearance \
  pavucontrol \
  i3lock-fancy \
  light \
  feh

sudo gpasswd -a $(whoami) video
sudo chmod +s $(which light)

