#!/bin/bash

if ! [[ -x "$(command -v xprintidle)" ]]; then
  echo "Error: xprintidle is not installed."
  exit 1
fi

if ! [[ -x "$(command -v xsecurelock)" ]]; then
  echo "Error: xsecurelock is not installed."
  exit 1
fi

if [[ -z $1 ]] || [[ -z $2 ]] || [[ -z $3 ]]; then
  echo "Error: set parameters: ac, battery, interval in seconds"
  echo "       e.g. autolock.sh 600 300 10"
  echo "       for 10min on ac, 5min on battery, 10sec checking interval" 
  exit 1
fi

pid=$(pgrep xsecurelock)
directory=$(cd "$(dirname "$0")" && pwd)
idleOffset=0

if [[ $pid -gt 2 ]]; then
    exit 1
fi

while :
do
   sleep $3
   idle=$(xprintidle)
   pid=$(pgrep xsecurelock)
   inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
   battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')

   if [[ $inhibit == "true" ]]; then
      idleOffset=$idle
   fi

   if [[ $idle -lt $idleOffset ]]; then
      idleOffset=0
   fi

   acTarget=$(($1 * 1000 + $idleOffset))
   batTarget=$(($2 * 1000 + $idleOffset))

   if [[ -z $pid ]]; then
      if [[ $idle -gt $acTarget && $battery == "false" ]] || [[ $idle -gt $batTarget && $battery == "true" ]]; then
	 env XSECURELOCK_BLANK_TIMEOUT=5 XSECURELOCK_AUTH_TIMEOUT=15 XSECURELOCK_SAVER=saver_blank XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 xsecurelock
      fi
   fi
done
