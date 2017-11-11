#!/bin/bash

basedir=$(dirname "$0")
xpos=1006

if (( $(xdotool getmouselocation | grep -o "x:[0-9]*" | grep -o "[0-9]*") > 1920 ))
then
    let "xpos = xpos + 1920"
fi

$basedir/exec-and-wait.py "pavucontrol"

i3-msg  "[class=Pavucontrol] floating enable, sticky enable, border none, resize set 760 px 536 px, move position $xpos px 518 px"

#let "xpos = xpos + 380"
#xdotool mousemove $xpos 786
