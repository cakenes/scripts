#!/bin/bash

set -e

cryptsetup luksOpen /dev/vda2 crypt

mount -o rw,noatime,compress=lzo,ssd,discard=async,space_cache=v2,subvolid=256,subvol=@ /dev/mapper/crypt /mnt
mount -o rw,noatime,compress=lzo,ssd,discard=async,space_cache=v2,subvolid=256,subvol=@home /dev/mapper/crypt /mnt/home
mount /dev/vda1 /mnt/boot

arch-chroot /mnt

