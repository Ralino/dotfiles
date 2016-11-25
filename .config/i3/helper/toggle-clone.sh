#!/bin/bash
toggle-clone
sleep 0.5

HORIZONTAL=$( xrandr -q  | grep -o -E "current [0-9]{4} x [0-9]{3}" | cut -b 9-13 )

if [ "$HORIZONTAL" -lt "1921" ]
then
    RAND=$RANDOM
    let "RAND >>= 14"
    if [ "$RAND" -eq 1 ]
    then
        feh --bg-scale "$1"
    else
        feh --bg-scale "$2"
    fi
else
    feh --bg-scale "$1" "$2"
fi
