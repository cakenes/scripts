#!/bin/bash

if [[ ! -x "$(command -v xautolock)" || ! -x "$(command -v xss-lock)" || ! -x "$(command -v killall)" ]]; then
  echo "Error: xautolock,killall and xss-lock must be installed."
  exit 1
fi

powerType=wall
checkInhibit=true

while :
do 
    pid=$(pidof -x xautolock)
    battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')

    sleep 1

    if [[ $battery == "false" && $powerType != wall && ! -z $pid ]]; then
        echo Killing xAutolock, changing to wall power.
        killall xautolock
    elif [[ $battery == "true" && $powerType != battery && ! -z $pid ]]; then
        echo Killing xAutolock, changing to battery power.
        killall xautolock
    fi

    if [[ $inhibit == "false" || $checkInhibit == "false" ]] && [[ -z $pid ]]; then
	if [[ $battery == "false" ]]; then
	    powerType=wall
            echo xAutolock ON with 10min timer.
            xautolock -time 10 -locker "sh $1/.config/scripts/screen-off.sh" &
        elif [[ $battery == "true" ]]; then
            powerType=battery
            echo xAutolock ON with 3min timer.
            xautolock -time 3 -locker "sh $1/.config/scripts/screen-off.sh" &
        fi
    fi

    if [[ $checkInhibit == "true" && $inhibit == "true" && ! -z $pid ]]; then
        echo Killing xAutolock, inhibiting
        killall xautolock
    fi
done
