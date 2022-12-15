#!/bin/bash

if ! [[ -x "$(command -v xprintidle)" ]]; then
  echo "Error: xprintidle is not installed."
  exit 1
fi

directory=$(cd "$(dirname "$0")" && pwd)

while :
do
   sleep 10

   screenoff=$(pidof -x screen-off.sh)
   inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
   battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')
   idle=$(xprintidle)

   if [[ -n $screenoff ]]; then
      continue
   elif [[ $inhibit == "false" ]]; then
      if [[ $idle -gt 60000 && $battery == "true" ]]; then
         sh $directory/screen-off.sh &
      elif [[ $idle -gt 360000 && $battery == "false" ]]; then
         sh $directory/screen-off.sh &
      fi
   fi
done
