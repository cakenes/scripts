#!/bin/bash

current=$(xinput --list-props "DELL08AF:00 06CB:76AF Touchpad" |grep 337 |awk '{print $7}')

if [[ $current == "0" ]]; then
   notify-send -t 2000 "Palm rejection ON"
   xinput --set-prop "DELL08AF:00 06CB:76AF Touchpad" 337 1
elif [[ $current == "1" ]]; then
   notify-send -t 2000 "Palm rejection OFF"
   xinput --set-prop "DELL08AF:00 06CB:76AF Touchpad" 337 0
fi

exit 1
