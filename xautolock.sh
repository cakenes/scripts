#!/bin/bash

let type=none

while :
do 
    echo $type
    pid=$(pidof -x xautolock)
    battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')

    if [ $battery == "false" ] && [ $type != wall ]; then
        killall xautolock
    elif [ $battery == "true" ] && [ $type != battery ]; then
        killall xautolock
    fi

    if [ $inhibit == "false" ] && [ -z $pid ]; then
	if [ $battery == "false" ]; then
	    let type=wall
            echo xautolock ON 15min
            xautolock -time 15 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        else
            let type=battery
            echo xautolock ON 5min
            xautolock -time 5 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        fi
    fi

    if [ $inhibit == "true" ] && [ ! -z $pid ]; then
        echo xautolock OFF
        killall xautolock
    fi

    sleep 10
done
