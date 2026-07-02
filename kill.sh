#!/bin/bash

focus=$(swaymsg -t get_tree | jq -r '.. | select(.focused? == true) | .name' 2>/dev/null | xargs)
ignore=("Path of Exile" "World of Warcraft" "ARK: Survival Evolved" "Last Epoch" "TheIsle")

for value in "${ignore[@]}"; do
	value=$(echo "$value" | xargs)
	if [[ $focus == "$value" ]]; then
		exit 1
	fi
done

swaymsg kill
