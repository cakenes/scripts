#!/bin/bash

#focus=$(xdotool getwindowfocus getwindowname)
#if [[ $focus != "World of Warcraft" ]]; then
#  exit 1
#fi

id=$(wmctrl -l | grep "World of Warcraft" | awk '{print $1}')
color=$(grabc -w $id -l +803+658)

sleep 0.1

if [ $color = "#0000ff" ]; then
  xdotool key "1"
elif [ $color = "" ]; then
  xdotool key "e"
else
  xdotool key "q"
fi
