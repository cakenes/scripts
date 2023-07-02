#!/bin/bash

if ! [[ -x "$(command -v xprintidle)" ]]; then
  echo "Error: xprintidle is not installed."
  exit 1
fi

if [[ -z $1 ]] || [[ -z $2 ]]; then
  echo "Error: parameters not set."
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
   sleep 10

   idle=$(xprintidle)
   pid=$(pgrep xsecurelock)
   inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
   battery=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement org.freedesktop.PowerManagement.GetOnBattery | awk NR==2'{print $2}')

   if [[ $inhibit == "true" ]]; then
      idleOffset=$idle
   elif [[ $inhibit == "false" ]] && [[ -z $pid ]]; then
      if [[ $idle -gt $(($1 * 60000 + $idleOffset)) && $battery == "true" ]]; then
	 env XSECURELOCK_BLANK_TIMEOUT=5 XSECURELOCK_AUTH_TIMEOUT=15 XSECURELOCK_SAVER=saver_blank XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 xsecurelock
      elif [[ $idle -gt $(($2 * 60000)) && $battery == "false" ]]; then
	 env XSECURELOCK_BLANK_TIMEOUT=5 XSECURELOCK_AUTH_TIMEOUT=15 XSECURELOCK_SAVER=saver_blank XSECURELOCK_DISCARD_FIRST_KEYPRESS=0 xsecurelock
      fi
   fi

   if [[ $idle -lt $idleOffset ]]; then
      idleOffset=0
   fi

done
