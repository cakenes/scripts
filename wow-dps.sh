#!/bin/bash

for pid in $(pidof -x wow-dps.sh); do
  if [ $pid != $$ ]; then
    killall wow-dps.sh
    notify-send -t 2000 "Stopped"
    exit 1
  fi
done

notify-send -t 2000 "Running"

while :
do

  sleeprandom=$(printf "0.2%01d\n" $(( RANDOM % 10 )))
  keyrandom=$(printf "0.01%01d\n" $(( RANDOM % 10 )))

  sleep $sleeprandom

  focus=$(xdotool getwindowfocus getwindowname)
  if [[ $focus != "World of Warcraft" ]]; then
    continue
  fi

  id=$(wmctrl -l | grep "World of Warcraft" | awk '{print $1}')
  color=$(grabc -w $id -l +429+1022)

  case $color in
    "#000000")
      continue
      ;;
    "#100000")
	# 1
      xdo key_press -k 10
      sleep $keyrandom
      xdo key_release -k 10
      ;;
    "#110000")
        # 2
      xdo key_press -k 11
      sleep $keyrandom
      xdo key_release -k 11
      ;;
    "#230000")
	# Tab
      xdo key_press -k 23
      sleep $keyrandom
      xdo key_release -k 23
      ;;
    "#240000")
	# Q
      xdo key_press -k 24
      sleep $keyrandom
      xdo key_release -k 24
      ;;
    "#260000")
	# E
      xdo key_press -k 26
      sleep $keyrandom
      xdo key_release -k 26
      ;;
  esac
done
