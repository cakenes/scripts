#!/bin/bash

focus=$(xdotool getwindowfocus getwindowname)
if [[ $focus == "Path of Exile" ]]; then
  exit 1
elif [[ $focus == "World of Warcraft" ]]; then
  exit 1
elif [[ $focus == "ARK: Survival Evolved" ]]; then
  exit 1
fi

wmctrl -c :ACTIVE:
