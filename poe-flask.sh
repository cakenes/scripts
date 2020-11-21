#!/bin/bash

timer=3.9

for pid in $(pidof -x poe-flask.sh); do
  if [ $pid != $$ ]; then
    notify-send -t 2000 "Stopped"
    killall poe-flask.sh
    exit 1
  fi
done

notify-send -t 2000 "Running"

while :
do

  sleeprandom=$(printf "0.2%01d\n" $(( RANDOM % 10 )))
  keyrandom=$(printf "0.05%01d\n" $(( RANDOM % 10 )))

  sleep $sleeprandom

  focus=$(xdotool getwindowfocus getwindowname)
  if [[ $focus != "Path of Exile" ]]; then
    continue
  fi

  for i in 2 3 4 5; do
    xdotool keydown $i
    sleep $keyrandom
    xdotool keyup $i
  done

  sleep $timer

done
