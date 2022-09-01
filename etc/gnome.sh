#!/bin/bash

# Gnome setup
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true

sudo apt remove \
  thunderbird \
  simple-scan \
  gnome-mines \
  gnome-todo \
  gnome-sudoku \
  gnome-mahjongg \
  deja-dup \
  aisleriot

sudo apt install gnome-shell-extensions
