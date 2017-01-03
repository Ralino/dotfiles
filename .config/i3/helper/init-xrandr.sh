#!/bin/bash

BASEDIR=$(dirname "$0")
STATUS=$(xrandr -q)
HORIZONTAL=$( echo "$STATUS" | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ -z "$( echo "$STATUS" | grep -o -E "HDMI1 disconnected")" ]
then
    xrandr --output HDMI1 --auto --primary --right-of eDP1
    xbacklight -set 20
    feh --bg-scale $($BASEDIR/pick-wallpaper.sh 2)
else
    xrandr --output eDP1 --auto --primary --output HDMI1 --off --output VGA1 --off
    xbacklight -set 1
    feh --bg-scale $($BASEDIR/pick-wallpaper.sh 1)
fi
