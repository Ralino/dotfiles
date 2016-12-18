#!/bin/bash

STATUS=$(xrandr -q)
HORIZONTAL=$( echo "$STATUS" | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ -z "$( echo "$STATUS" | grep -o -E "HDMI1 disconnected")" ]
then
    xrandr --output HDMI1 --auto --primary --right-of eDP1
    xbacklight -set 20
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 2)
else
    xrandr --output eDP1 --auto --primary
    xbacklight -set 1
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 1)
fi
