#!/bin/bash

while :
do 
    inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
    pid=$(pidof -x xautolock)

    if [ $inhibit != "true" ] && [ -z $pid ]; then
        echo xautolock ON
        xautolock -time 15 -locker "sh /home/used/.config/scripts/screen-off.sh" &
    fi

    if [ $inhibit != "false" ] && [ ! -z $pid ]; then
        echo xautolock OFF
        killall xautolock
    fi

    sleep 10
done
