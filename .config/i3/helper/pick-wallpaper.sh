#!/bin/bash
#

num=0
files="$HOME/wallpaper/*.png"

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
    let "rand %= $num"
    echo -n "${fileArray[$rand]} "
    let "num--"
    fileArray[$rand]=${fileArray[$num]}
done
