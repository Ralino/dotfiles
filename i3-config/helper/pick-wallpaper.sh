#!/bin/bash
basedir=$(dirname "$0")

num=0
if $basedir/dual-head.sh; then
  # Assume hd
  files="$HOME/media/bilder/foxes_wallpaper/fav/*.png"
else
    if [ "$(xrandr -q | grep -E "^LVDS1" | grep "768x1366")" ]; then
        files="$HOME/media/bilder/foxes_wallpaper/low_res/rotated/*.png"
  else
      files="$HOME/media/bilder/foxes_wallpaper/low_res/*.png"
  fi
fi


if [ -z $1 ]; then
    requested=1
else
    requested=$1
fi

for img in $files; do
    fileArray[$num]=$img
    let "num++"
done

if (( $num < $requested )); then
    echo "Not enough pictures to satisfy request."
    exit 1
fi

for req in `seq $requested`; do
    rand=$RANDOM
    while (( $rand >= (32768 / $num) * $num )); do
        rand=$RANDOM
    done
    let "rand %= $num"
    echo -n "${fileArray[$rand]} "
    let "num--"
    fileArray[$rand]=${fileArray[$num]}
done
