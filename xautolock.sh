#!/bin/bash

while :
do 
    battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
    pid=$(pidof -x xautolock)

    echo $battery

    if [ $inhibit == "false" ] && [ -z $pid ]; then
        echo xautolock ON
	if [ $battery == "false" ]; then
            xautolock -time 15 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        else
            xautolock -time 5 -locker "sh /home/used/.config/scripts/screen-off.sh" &
        fi
    fi

    if [ $inhibit == "true" ] && [ ! -z $pid ]; then
        echo xautolock OFF
        killall xautolock
    fi

    sleep 10
done