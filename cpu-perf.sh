#!/bin/bash

current=$(cat /sys/devices/system/cpu/intel_pstate/max_perf_pct)

if [[ $current == "100" ]]; then
   notify-send -t 2000 "Max Performance 20%"
   echo "20" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
else
   notify-send -t 2000 "Max Perfromance 100%"
   echo "100" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
fi

exit 1

if [[ $current == "100" ]]; then
   notify-send -t 2000 "Max performance: 80%"
   echo "80" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
elif [[ $current == "80" ]]; then
   notify-send -t 2000 "Max performance: 60%"
   echo "60" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
elif [[ $current == "60" ]]; then
   notify-send -t 2000 "Max performance: 40%"
   echo "40" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
elif [[ $current == "40" ]]; then
   notify-send -t 2000 "Max perfromance: 20%"
   echo "20" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
else
   notify-send -t 2000 "Max perfromance: 100%"
   echo "100" | ~/.config/scripts/tee /sys/devices/system/cpu/intel_pstate/max_perf_pct
fi

exit 1
