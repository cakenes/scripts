#!/bin/bash

sudo pacman -S git

git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si
cd ..
rm -fr yay/

yay -S discord blender gimp inkscape krita lollypop lutris obs-studio picom deluge-gtk gameconqueror shotcut vlc
