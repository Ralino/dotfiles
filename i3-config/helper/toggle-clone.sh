#!/bin/bash
set -e
basedir=$(dirname "$0")

if ! $basedir/dual-head.sh; then
  xrandr --output LVDS1 --auto --primary --scale 1x1 \
         --output HDMI1 --off \
         --output VGA1  --off
  sleep 0.5
  feh --bg-scale $($basedir/pick-wallpaper.sh 1)
  $basedir/polybar.sh
  xsetwacom --set "Wacom ISDv4 90 Pen stylus" MapToOutput LVDS1
  xsetwacom --set "Wacom ISDv4 90 Pen eraser" MapToOutput LVDS1
  exit 1
fi

internal="LVDS1"
internal_size="1366x768"
internal_horizontal=$(echo "$internal_size" | sed -E 's/x[0-9]+//')
internal_vertical=$(echo   "$internal_size" | sed -E 's/[0-9]+x//')

clone()
{
  if (( $internal_horizontal < $external_horizontal )); then
    xrandr --output $external --auto --primary \
           --output $internal --same-as $external --scale-from $external_size
  else
    xrandr --output $internal --auto --primary \
           --output $external --same-as $internal --scale-from $internal_size
  fi
  sleep 0.5
  feh --bg-scale $($basedir/pick-wallpaper.sh 1)
  $basedir/polybar.sh
  xsetwacom --set "Wacom ISDv4 90 Pen stylus" MapToOutput $internal
  xsetwacom --set "Wacom ISDv4 90 Pen eraser" MapToOutput $internal
}

extend()
{
  if (( $internal_vertical < $external_vertical )); then
    let "diff = $external_vertical - $internal_vertical"
    xrandr --output $external --auto --primary   --pos ${internal_horizontal}x0 \
           --output $internal --auto --scale 1x1 --pos 0x$diff
  else
    xrandr --output $external --auto --primary --right-of $internal \
           --output $internal --auto --scale 1x1
  fi
  sleep 0.5
  feh --bg-scale $($basedir/pick-wallpaper.sh 2)
  $basedir/polybar.sh
  xsetwacom --set "Wacom ISDv4 90 Pen stylus" MapToOutput $internal
  xsetwacom --set "Wacom ISDv4 90 Pen eraser" MapToOutput $internal
}

external-only()
{
  xrandr --output $external --auto --primary \
         --output $internal --off

  sleep 0.5
  feh --bg-scale $($basedir/pick-wallpaper.sh 1)
  $basedir/polybar.sh
  xsetwacom --set "Wacom ISDv4 90 Pen stylus" MapToOutput $external
  xsetwacom --set "Wacom ISDv4 90 Pen eraser" MapToOutput $external
}

main()
{
while read line; do
  if [ "$(echo "$line" | grep -E "(HDMI1|VGA1) connected")" ]; then
    external="$(echo "$line" | grep -oE "(HDMI1|VGA1)")"
    while read line; do
      if [ "$(echo "$line" | grep -F "*")" ]; then
        external_size="$(echo "$line" | grep -oE "[0-9]+x[0-9]+")"
        external_horizontal=$(echo "$external_size" | sed -E 's/x[0-9]+//')
        external_vertical=$(echo   "$external_size" | sed -E 's/[0-9]+x//')
        break
      fi
    done
    break
  fi
done

case $1 in
  "extend")
    extend
    ;;
  "clone")
    clone
    ;;
  "external-only")
    external-only
    ;;
  *)
    # toggle
    total_horizontal=$(xrandr -q | head -n 1 | grep -oE "current [0-9]+ x" | grep -oE "[0-9]+")
    if (( $total_horizontal < $internal_horizontal + $external_horizontal )); then
      extend
    else
      clone
    fi
    ;;
esac
}

xrandr -q | main $@


