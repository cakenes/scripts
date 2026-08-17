#!/usr/bin/env bash

command -v jq >/dev/null 2>&1 || {
    echo >&2 "Error: 'jq' is required."
    exit 1
}

swaymsg -t get_tree | jq -r '
  .. 
  | select(.type? == "workspace") as $ws
  | .. 
  | select(.pid? and (.app_id? or .window_properties?))
  | [
      ($ws.name // "N/A"),
      (.app_id // .window_properties.class // "N/A"),
      (.name // .window_properties.title // "N/A")
    ]
  | @tsv
' | awk -F'\t' 'BEGIN {printf "%-12s %-25s %s\n", "WORKSPACE", "CLASS/APP_ID", "TITLE"} {printf "%-12s %-25s %s\n", $1, $2, $3}'
