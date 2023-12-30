#!/usr/bin/env bash
set -e

# Import custom shortcuts
# Note dump:  dconf dump /org/gnome/settings-daemon/plugins/media-keys/ > custom_shortcut
echo "Import custom shortcuts"
cat ~/.dotfiles/etc/gnome_custom_shortcut | dconf load /org/gnome/settings-daemon/plugins/media-keys/
gsettings set org.gnome.mutter overlay-key ''
gsettings set org.gnome.desktop.wm.keybindings close "['<Shift><Super>q']"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source "[]"
gsettings set org.gnome.desktop.wm.keybindings switch-input-source-backward "[]"

# Gnome setup
gsettings set org.gnome.desktop.interface show-battery-percentage true
gsettings set org.gnome.desktop.interface clock-show-weekday true
gsettings set org.gnome.desktop.interface clock-show-date true
gsettings set org.gnome.desktop.interface enable-animations false
gsettings set org.gnome.mutter dynamic-workspaces false
gsettings set org.gnome.desktop.wm.preferences num-workspaces 1
