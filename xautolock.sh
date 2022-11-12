#!/bin/bash

type=wall

while :
do 
    pid=$(pidof -x xautolock)
    battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')

    if [ $battery == "false" ] && [ $type != wall ]; then
        echo Killing xAutolock, changing to wall power.
        killall xautolock
    elif [ $battery == "true" ] && [ $type != battery ]; then
        echo Killing xAutolock, changing to battery power.
        killall xautolock
    fi

    if [ $inhibit == "false" ] && [ -z $pid ]; then
	if [ $battery == "false" ]; then
	    type=wall
            echo xAutolock ON with 15min timer.
            xautolock -time 15 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        else
            type=battery
            echo xAutolock ON with 5min timer.
            xautolock -time 5 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        fi
    fi

    if [ $inhibit == "true" ] && [ ! -z $pid ]; then
        echo Killing xAutolock, inhibiting
        killall xautolock
    fi

    sleep 10
done
