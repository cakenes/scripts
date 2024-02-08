#!/bin/bash

focus=$(xdotool getwindowfocus getwindowname)
ignore=("Path of Exile" "World of Warcraft" "ARK: Survival Evolved" "Last Epoch")

for value in "${ignore[@]}"; do
   if [[ $focus == $value ]]; then
      exit 1
   fi
done

wmctrl -c :ACTIVE:
