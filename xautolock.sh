#!/bin/bash

if ! [[ -x "$(command -v xautolock)" ]] || ! [[ -x "$(command -v killall)" ]]; then
  echo "Error: xautolock or killall is not installed."
  exit 1
fi

type=wall

while :
do 
    pid=$(pidof -x xautolock)
    battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')

    sleep 1

    if [[ $battery == "false" ]] && [[ $type != wall ]] && [[ ! -z $pid ]]; then
        echo Killing xAutolock, changing to wall power.
        killall xautolock
    elif [[ $battery == "true" ]] && [[ $type != battery ]] && [[ ! -z $pid ]]; then
        echo Killing xAutolock, changing to battery power.
        killall xautolock
    fi

    if [[ $inhibit == "false" ]] && [[ -z $pid ]]; then
	if [[ $battery == "false" ]]; then
	    type=wall
            echo xAutolock ON with 10min timer.
            xautolock -time 10 -locker "sh ~/.config/scripts/screen-off.sh" &
        elif [[ $battery == "true" ]]; then
            type=battery
            echo xAutolock ON with 3min timer.
            xautolock -time 3 -locker "sh ~/.config/scripts/screen-off.sh" &
        fi
    fi

    if [[ $inhibit == "true" ]] && [[ ! -z $pid ]]; then
        echo Killing xAutolock, inhibiting
        killall xautolock
    fi

done
