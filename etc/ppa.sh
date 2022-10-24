#!/usr/bin/env bash

sudo add-apt-repository ppa:peek-developers/stable
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo
sudo add-apt-repository ppa:obsproject/obs-studio

sudo apt -y install peek obs-studio ibus-bamboo
