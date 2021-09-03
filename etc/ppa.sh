#!/bin/bash

sudo add-apt-repository ppa:neovim-ppa/unstable
sudo add-apt-repository ppa:peek-developers/stable
sudo add-apt-repository ppa:bamboo-engine/ibus-bamboo

sudo apt install \
  neovim \
  peek \
  ibus-bamboo
