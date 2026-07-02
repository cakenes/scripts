#!/bin/bash

# Switch to workspace 1 and load layout
swaymsg 'workspace 1'
swaymsg "append_layout /home/used/.config/sway/workspace-1.json"

# Launch workspace 1 apps — order matches layout swallows
discord &
librewolf 'https://music.youtube.com/' &
alacritty &

# Launch workspace 2 apps
swaymsg 'workspace 2'
steam &
