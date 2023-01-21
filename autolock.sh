#!/bin/bash

if ! [[ -x "$(command -v xprintidle)" ]]; then
  echo "Error: xprintidle is not installed."
  exit 1
fi

if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo "Error: parameters not set."
  exit 1
fi

pid=$(pgrep -f autolock.sh | wc --lines)
directory=$(cd "$(dirname "$0")" && pwd)
idleOffset=0

if [[ $pid -gt 2 ]]; then
    exit 1
fi

while :
do
   sleep 10

   idle=$(xprintidle)
   pid=$(pgrep -f screen-off.sh)
   inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
   battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')

   if [[ $inhibit == "true" ]]; then
      idleOffset=$idle
   fi

   if [[ $idle -lt $idleOffset ]]; then
      idleOffset=0
   fi

   if [[ $inhibit == "false" ]]; then
      if [[ $idle -gt $(($1 * 60000 + $idleOffset)) && $battery == "true" ]]; then
         sh $directory/screen-off.sh &
      elif [[ $idle -gt $(($2 * 60000)) && $battery == "false" ]]; then
         sh $directory/screen-off.sh &
      fi
   fi
done
