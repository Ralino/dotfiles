#!/bin/sh

VALUE="5"
[ -n "$1" ] && VALUE="$1"

if [ $(xbacklight | grep -oE "[0-9]+\." | grep -oE "[0-9]+") -ge $VALUE ]; then
	xbacklight -$VALUE%; else
	xbacklight -set 1
fi
