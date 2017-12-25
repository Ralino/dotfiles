#!/bin/bash
basedir=$(dirname "$0")

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

if $basedir/dual-head.sh; then
  if [ "$(xrandr -q | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13)" -gt "1920" ]; then
    polybar primary &
    polybar secondary &
  else
    polybar clone &
  fi
else
  polybar primary &
fi

