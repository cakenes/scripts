#!/bin/bash

for pid in $(pidof -x screen-off.sh); do
    if [[ $pid != $$ ]]; then
        exit 1
    fi
done

xset s activate

while :
do
    sleep 5
    pid=$(pidof -x i3lock)
    idle=$(xprintidle)
    monitor=$(xset q -display :0 | grep 'Monitor is On')

    if [[ -z $pid ]]; then
        exit 1
    elif [[ 10000 -lt $idle ]] && [[ -n $monitor ]]; then
        xset dpms force off
    fi
done
