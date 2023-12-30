#!/usr/bin/env bash
set -e

sudo dnf install i3 \
  dunst \
  hsetroot \
  keychain \
  light \
  lxappearance \
  pavucontrol \
  rofi \
  xinput \
  xset \
  xss-loctk

sudo chmod +s $(which light)

# ibus issue
# https://github.com/BambooEngine/ibus-bamboo/issues/193
# im-chooser > Use-ibus > logout
