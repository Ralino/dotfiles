#!/bin/bash

basedir=$(dirname "$0")

echo "Calling init-xrandr.sh ..."
$basedir/init-xrandr.sh &
echo "Stripping opacity values ..."
$basedir/strip-opacity.py &
killall compton
compton -f -b
#echo "Starting hotspot ..."
#sudo /usr/local/bin/apstarter &
echo "Calling battery-warning ..."
$basedir/battery-warning.sh &
