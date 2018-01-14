#!/bin/bash
basedir=$(dirname "$0")

STATUS=$(xrandr -q)
HORIZONTAL=$( echo "$STATUS" | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ -z "$( echo "$STATUS" | grep -o -E "HDMI1 disconnected")" ]
then
    echo "HDMI1"
    if [  "$HORIZONTAL" -lt "1921" ]
    then
        xrandr --output HDMI1 --auto --primary --left-of eDP1
    else
        xrandr --output HDMI1 --auto --output eDP1 --auto --same-as HDMI1
    fi
else
    if [ -z "$( echo "$STATUS" | grep -o -E "VGA1 disconnected")" ]
    then
        echo "VGA1"
        if [  "$HORIZONTAL" -lt "1921" ]
        then
            xrandr --output VGA1 --auto --primary --left-of eDP1
        else
            xrandr --output VGA1 --auto --output eDP1 --auto --same-as VGA1
        fi
    else
        xrandr --output eDP1 --auto --primary --output HDMI1 --off --output VGA1 --off
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

$basedir/polybar.sh
