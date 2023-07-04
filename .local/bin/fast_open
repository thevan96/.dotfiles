#!/usr/bin/env bash

xdg-open $(
  fd . $HOME --type d -H \
  --exclude .git \
  --exclude .idea \
  --exclude .vscode \
  --exclude node_modules \
  --exclude vendor \
  --exclude composer \
  --exclude gems | rofi -dmenu -window-title 'Folder')
