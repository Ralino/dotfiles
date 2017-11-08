#!/bin/bash

STATUS=$(xrandr -q)
HORIZONTAL=$( echo "$STATUS" | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ -z "$( echo "$STATUS" | grep -o -E "HDMI-1 disconnected")" ]
then
    echo "HDMI-1"
    if [  "$HORIZONTAL" -lt "1921" ]
    then
        xrandr --output HDMI-1 --auto --primary --right-of eDP-1
    else
        xrandr --output HDMI-1 --auto --output eDP-1 --auto --same-as HDMI-1
    fi
else
    if [ -z "$( echo "$STATUS" | grep -o -E "VGA-1 disconnected")" ]
    then
        echo "VGA-1"
        if [  "$HORIZONTAL" -lt "1921" ]
        then
            xrandr --output VGA-1 --auto --primary --right-of eDP-1
        else
            xrandr --output VGA-1 --auto --output eDP-1 --auto --same-as VGA-1
        fi
    else
        xrandr --output eDP-1 --auto --primary --output HDMI-1 --off --output VGA-1 --off
    fi
fi

sleep 0.5

HORIZONTAL=$(xrandr -q | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )
if [ "$HORIZONTAL" -lt "1921" ]
then
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 1)
else
    feh --bg-scale $(~/.config/i3/helper/pick-wallpaper.sh 2)
fi
