#!/bin/bash

basedir=$(dirname "$0")
external_screen=$(cat /home/ralino/.config/i3/config | grep "^set \$external_screen" | grep -o -E "[[:alnum:]-]+$")

blsingle=1
bldual=20

if [ -f $basedir/.backlight ]; then
    { read blsingle; read bldual; } < $basedir/.backlight
fi

if (( $blsingle < 1 )) || (( $blsingle > 100 )); then
    blsingle=1
    echo "$blsingle" > $basedir/.backlight
    echo "$bldual" >> $basedir/.backlight
fi

if (( $bldual < 1 )) || (( $bldual > 100 )); then
    bldual=20
    echo "$blsingle" > $basedir/.backlight
    echo "$bldual" >> $basedir/.backlight
fi

if $basedir/dual-head.sh; then
    xrandr --output $external_screen --auto --primary --right-of LVDS1
    xbacklight -set $bldual
    feh --bg-scale $($basedir/pick-wallpaper.sh 2)

    #workaround to stop i3 from crashing
    sleep 0.5
    xdotool mousemove_relative 1 0
else
    xrandr --output LVDS1 --auto --primary --output HDMI1 --off --output VGA1 --off
    xbacklight -set $blsingle
    feh --bg-scale $($basedir/pick-wallpaper.sh 1)
fi
