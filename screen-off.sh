#!/bin/bash

for pid in $(pidof -x screen-off.sh); do
    if [ $pid != $$ ]; then
        exit 1
    fi
done

xset s activate
sleep 5
xset dpms force off

while :
do
    sleep 30
    pid=$(pidof -x i3lock)
    if [[ ! -z $pid ]]; then
        xset dpms force off
    else
        exit 1
    fi
done
