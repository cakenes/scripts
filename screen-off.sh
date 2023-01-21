#!/bin/bash

if ! [[ -x "$(command -v i3lock)" ]] || ! [[ -x "$(command -v xprintidle)" ]]; then
  echo "Error: i3lock or xprintidle is not installed."
  exit 1
fi

pid=$(pgrep -f screen-off.sh)

if [[ -z $pid ]]; then
    exit 1
fi

xset s activate

while :
do
    sleep 5
    pid=$(pidof -x i3lock)
    idle=$(xprintidle)

    if [[ -z $pid ]]; then
        exit 1
    elif [[ 10000 -lt $idle ]]; then
        xset dpms force off
    fi
done
