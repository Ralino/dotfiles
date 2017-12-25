#!/bin/bash

basedir=$(dirname "$0")
echo "Calling init-xrandr.sh ..."
$basedir/init-xrandr.sh &
echo "(Re)starting polybar(s) ..."
$basedir/polybar.sh &
#echo "Starting hotspot ..."
#sudo /usr/local/bin/apstarter &
echo "Calling battery-warning ..."
$basedir/battery-warning.sh &
