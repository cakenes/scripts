#!/bin/bash

#
#
#
#
#
#
#
#

sudo pacman -S yay

# bash
yay -S bash-completion

# programs
yay -S alacritty balena-etcher blender discord galculator gimp inkscape krita lollypop lutris neofetch obs-studio steam visual-studio-code-bin vlc yuzu-mainline-bin libreoffice-fresh virt-viewer virt-manager

# graphical
yay -S picom rofi dmenu-height neofetch htop xss-lock betterlockscreen polybar i3-gaps feh nerd-fonts-complete libinput-gestures grsync

# misc
yay -S intel-undervolt i8kutils timeshift xdotool wmctrl kid3-qt easytag qemu hid-nintendo-dkms dell-bios-fan-control-git ebtables

# chromecast
yay -S libmicrodns protobuf

# dotnet
yay -S dotnet-host dotnet-runtime dotnet-sdk dotnet-targeting-pack

# print / scan
yay -S cups sane-airscan simple-scan

# wine
yay -S wine-staging giflib lib32-giflib libpng lib32-libpng libldap lib32-libldap gnutls lib32-gnutls mpg123 lib32-mpg123 openal lib32-openal v4l-utils lib32-v4l-utils libpulse lib32-libpulse libgpg-error lib32-libgpg-error alsa-plugins lib32-alsa-plugins alsa-lib lib32-alsa-lib libjpeg-turbo lib32-libjpeg-turbo sqlite lib32-sqlite libxcomposite lib32-libxcomposite libxinerama lib32-libgcrypt libgcrypt lib32-libxinerama ncurses lib32-ncurses opencl-icd-loader lib32-opencl-icd-loader libxslt lib32-libxslt libva lib32-libva gtk3 lib32-gtk3 gst-plugins-base-libs lib32-gst-plugins-base-libs vulkan-icd-loader lib32-vulkan-icd-loader

# vulkan
#yay -S nvidia-dkms nvidia-utils lib32-nvidia-utils nvidia-settings vulkan-icd-loader lib32-vulkan-icd-loader
yay -S lib32-mesa vulkan-intel lib32-vulkan-intel vulkan-icd-loader lib32-vulkan-icd-loader

# battle.net
yay -S lib32-gnutls lib32-libldap lib32-libgpg-error lib32-sqlite lib32-libpulse

# xfce remove
sudo pacman -Rscn midori lightdm light-locker

# services
sudo systemctl enable sshd && sudo systemctl start sshd
sudo systemctl enable cups-browsed && sudo systemctl start cups-browsed
sudo systemctl enable intel-undervolt && sudo systemctl start intel-undervolt
sudo systemctl enable i8kmon && sudo systemctl start i8kmon
sudo systemctl enable libvirtd && sudo systemctl start libvirtd
sudo systemctl enable dell-bios-fan-control && sudo systemctl start dell-bios-fan-control

# virt-manager
sudo usermod -a -G libvirt $USER
