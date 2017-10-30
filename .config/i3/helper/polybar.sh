#!/bin/bash
basedir=$(dirname "$0")

killall -q polybar

while pgrep -u $UID -x polybar >/dev/null; do sleep 0.1; done

polybar primary &
if $basedir/dual-head.sh; then
  polybar secondary &
fi

