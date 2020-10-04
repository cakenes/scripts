#!/bin/bash

vm="win10"

qemu=$(pidof -x qemu-system-x86_64)
if [ -z $qemu ]; then
  virsh --connect qemu:///system start $vm
fi

virt-viewer --connect qemu:///system $vm

while :
do
  sleep 1
  viewer=$(pidof -x virt-viewer)
  if [ -z $viewer ]; then
    virsh --connect qemu:///system shutdown $vm
    exit 1
  fi
done
