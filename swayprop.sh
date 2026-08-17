#!/usr/bin/env bash

# Exit if slurp or jq are missing
command -v slurp >/dev/null 2>&1 || {
    echo >&2 "Error: 'slurp' is required but not installed."
    exit 1
}
command -v jq >/dev/null 2>&1 || {
    echo >&2 "Error: 'jq' is required but not installed."
    exit 1
}

# Interactive click target selection via slurp
PT=$(slurp -p -f '{"x":%x,"y":%y}' 2>/dev/null)

# If selection was cancelled (e.g. pressed Esc)
if [ -z "$PT" ]; then
    echo "Cancelled."
    exit 0
fi

# Fetch tree and match window geometry
swaymsg -t get_tree | jq --argjson pt "$PT" '
  .. 
  | select(.rect? and (.type? == "con" or .type? == "floating_con") and .name? != null) 
  | select(
      .rect.x <= $pt.x and $pt.x <= (.rect.x + .rect.width) and 
      .rect.y <= $pt.y and $pt.y <= (.rect.y + .rect.height)
    )
' | jq -s 'last | {
  title: .name,
  app_id: .app_id,
  class: .window_properties.class,
  instance: .window_properties.instance,
  shell: .shell,
  pid: .pid,
  id: .id,
  focused: .focused,
  rect: .rect
}'
