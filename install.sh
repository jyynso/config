#!/usr/bin/env bash

#symlink shell
ln -sf ~/conf/.zshrc ~/.zshrc

#symlink configs
mkdir -p ~/.config
ln -sf ~/conf/kitty ~/.config/kitty
ln -sf ~/conf/fastfetch ~/.config/fastfetch

#restore gnome
dconf load / < ~/conf/gnome/bak.conf

echo ":D"
