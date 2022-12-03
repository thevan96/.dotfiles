#!/usr/bin/env bash

# Gnome setup
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false

gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 10

sudo apt remove \
  thunderbird \
  simple-scan \
  gnome-mines \
  gnome-todo \
  gnome-sudoku \
  gnome-mahjongg \
  deja-dup \
  aisleriot

sudo apt install gnome-shell-extensions\
  gnome-clocks \
  gnome-tweaks \
  chrome-gnome-shell \
  gnome-shell-pomodoro
