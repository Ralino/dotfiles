#!/bin/bash

STATUS=$(xrandr -q)

if [ "$( echo "$STATUS" | grep -o -E "HDMI1 disconnected")" ]; then
    exit 1
else
    exit 0
fi

