#!/bin/bash

current=$(cat /sys/devices/system/cpu/intel_pstate/no_turbo)

if [[ $current == "0" ]]; then
   notify-send -t 2000 "Turbo Disabled"
   echo 1 | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/no_turbo
elif [[ $current == "1" ]]; then
   notify-send -t 2000 "Turbo Enabled"
   echo 0 | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/no_turbo
fi
