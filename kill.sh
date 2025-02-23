#!/bin/bash

focus=$(xdotool getwindowfocus getwindowname | xargs)
ignore=("Path of Exile" "World of Warcraft" "ARK: Survival Evolved" "Last Epoch" "TheIsle")

for value in "${ignore[@]}"; do
	value=$(echo "$value" | xargs)
	if [[ $focus == "$value" ]]; then
		exit 1
	fi
done

wmctrl -c :ACTIVE:
