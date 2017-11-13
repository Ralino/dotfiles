#!/bin/bash

# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon=" "

player_status=$(playerctl status 2> /dev/null)
if [[ $? -eq 0 ]]; then
    metadata="$(playerctl metadata artist) - $(playerctl metadata album) - $(playerctl metadata title)"
    if (( $(echo "$metadata" | wc -m) > 65 )); then
      metadata="$(playerctl metadata artist) - $(playerctl metadata title)"
    fi
fi

# Foreground color formatting tags are optional
if [[ $player_status = "Playing" ]]; then
    echo "%{F#FE8019}$icon %{F#EBDBB2}$metadata"
elif [[ $player_status = "Paused" ]]; then
    echo "%{F#FE8019}$icon %{F#EBDBB2}$metadata"
else
    echo ""
fi
