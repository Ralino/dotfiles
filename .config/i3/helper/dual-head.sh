#!/bin/bash

external_screen=$(cat ~/.config/i3/config | grep "^set \$external_screen" | grep -o -E "[[:alnum:]]+$")
STATUS=$(xrandr -q)

if [ "$( echo "$STATUS" | grep -o -E "$external_screen disconnected")" ]; then
    exit 1
else
    exit 0
fi

