#!/bin/bash

for pid in $(pidof -x wow-dps.sh); do
  if [ $pid != $$ ]; then
    notify-send -t 2000 "Stopped"
    killall wow-dps.sh
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
  if [[ $focus != "World of Warcraft" ]]; then
    continue
  fi

  id=$(wmctrl -l | grep "World of Warcraft" | awk '{print $1}')
  color=$(grabc -w $id -l +429+1022)

  if [[ $color == "#000000" ]]; then
    continue
  else
    xdo key_press -k ${color:1:2}
    sleep $keyrandom
    xdo key_release -k ${color:1:2}
  fi

done
