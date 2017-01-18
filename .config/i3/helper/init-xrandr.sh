#!/bin/bash

basedir=$(dirname "$0")

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
    xrandr --output HDMI1 --auto --primary --right-of eDP1
    xbacklight -set $bldual
    feh --bg-scale $($basedir/pick-wallpaper.sh 2)
else
    xrandr --output eDP1 --auto --primary --output HDMI1 --off --output VGA1 --off
    xbacklight -set $blsingle
    feh --bg-scale $($basedir/pick-wallpaper.sh 1)
fi
