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

if [ "$(xrandr -q | grep -E "^LVDS1.*inverted (normal")" ]; then
  $basedir/toggle-clone.sh clone
else
  $basedir/toggle-clone.sh extend
fi
if $basedir/dual-head.sh; then
  xbacklight -set $bldual
  #workaround to stop i3 from crashing
  sleep 0.5
  xdotool mousemove_relative 1 0
else
  xbacklight -set $blsingle
fi
