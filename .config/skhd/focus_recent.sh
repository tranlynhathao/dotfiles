#!/bin/bash
#
# # Get the list of visible windows in the current space, sorted by recent order (most recent first)
# windows=$(yabai -m query --windows --space | jq 'sort_by(.recent) | reverse | map(select(.["is-visible"] == true)) | .[].id')
#
# # Get the list (no options)
# # windows=$(yabai -m query --windows --space | jq 'sort_by(.recent) | reverse | .[].id')
#
# # Get the ID of the current window
# current_window=$(yabai -m query --windows --window | jq '.id')
#
# # Get the most recent window, but different from the current window
# next_window=$(echo "$windows" | grep -v "$current_window" | head -n 1)
#
# # If a next window is found, focus on it
# if [ -n "$next_window" ]; then
#   yabai -m window --focus "$next_window"
# else
#   echo "No window to focus."
# fi

# Get visible windows sorted by recent use
windows=$(yabai -m query --windows --space | jq 'sort_by(.recent) | reverse | map(select(.["is-visible"] == true)) | .[].id')

# Get ID of current focused window (stripped of newline)
current_window=$(yabai -m query --windows --window | jq -r '.id')

# Find the next window that is not the current one
next_window=$(echo "$windows" | grep -v "^$current_window$" | head -n 1)

# Focus it if found
if [ -n "$next_window" ]; then
  yabai -m window --focus "$next_window"
else
  echo "No window to focus."
fi
