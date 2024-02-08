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
  echo "       e.g. autolock.sh 600 900 10"
  echo "       for 10min for lockscreen, 15min for screen off, 10sec checking interval" 
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
   inhibit="false"
   battery="false"

   if [[ -x "$(command -v xfce4-session)" ]]; then
      inhibit=$(dbus-send --session --print-reply --dest=org.freedesktop.PowerManagement /org/freedesktop/PowerManagement/Inhibit org.freedesktop.PowerManagement.Inhibit.HasInhibit | awk NR==2'{print $2}')
   fi   
      
   if [[ $inhibit == "true" ]]; then
      idleOffset=$idle
   fi

   if [[ $idle -lt $idleOffset ]]; then
      idleOffset=0
   fi
	
   lockTarget=$(($1 * 1000 + $idleOffset))
   offTarget=$(($2 * 1000 + $idleOffset))

   if [[  -z $pid ]] && [[ $1 -gt 0 ]] && [[ $idle -gt $lockTarget ]]; then
      xsecurelock
   fi
 
   if [[ $2 -gt 0 ]] && [[ $idle -gt $offTarget ]]; then
      xrandr --output DP-2 --off --output DP-0 --off
   else
      xrandr --output DP-2 --mode 3440x1440 --rate 75 --output DP-0 --off
   fi
done
