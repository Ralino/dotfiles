#!/bin/bash
toggle-clone
sleep 0.5

HORIZONTAL=$( xrandr -q  | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ "$HORIZONTAL" -lt "1921" ]
then
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 1)
else
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 2)
fi
