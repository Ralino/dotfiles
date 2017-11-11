#!/bin/bash

basedir=$(dirname "$0")



single=1
dual=20

if [ -f $basedir/.backlight ]; then
    { read single; read dual; } < $basedir/.backlight
fi

if [ $(echo "$1" | grep -E "^\+[0-9]*$") ]; then
    xbacklight $1%
else
    if [ $(echo "$1" | grep -E "^\-[0-9]*$") ]; then
        if [ $(xbacklight | grep -oE "[0-9]+\." | grep -oE "[0-9]+") -ge $(echo "$1" | grep -oE "[0-9]+") ]; then
            xbacklight $1%; else
            xbacklight -set 1
        fi
    else
        echo "Unknown or missing argument"
        exit 1
    fi
fi

if $basedir/dual-head.sh; then
    dual=$(xbacklight | grep -oE "[0-9]+\." | grep -oE "[0-9]+")
    if [ $(xbacklight | grep -oE "\.[5-9]") ]; then
        let "dual = $dual + 1"
    fi
else
    single=$(xbacklight | grep -oE "[0-9]+\." | grep -oE "[0-9]+")
    if [ $(xbacklight | grep -oE "\.[5-9]") ]; then
        let "single = $single + 1"
    fi
fi

echo "$single" > $basedir/.backlight
echo "$dual" >> $basedir/.backlight
