#!/bin/bash

rm -f ~/.config/fontconfig/fonts.conf/10-sub-pixel-*

if [ "$(xrandr -q | grep 'inverted (normal')" ]; then
  xrandr --output LVDS1 --rotate normal
  xsetwacom set "Wacom ISDv4 90 Pen stylus" Rotate none
  xsetwacom set "Wacom ISDv4 90 Pen eraser" Rotate none
  ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf ~/.config/fontconfig/fonts.conf
else
  xrandr --output LVDS1 --rotate inverted
  xsetwacom set "Wacom ISDv4 90 Pen stylus" Rotate half
  xsetwacom set "Wacom ISDv4 90 Pen eraser" Rotate half
  ln -s /etc/fonts/conf.avail/10-sub-pixel-bgr.conf ~/.config/fontconfig/fonts.conf
fi

fc-cache
