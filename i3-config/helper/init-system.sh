#!/bin/sh

basedir=$(dirname "$0")
echo "Calling init-xrandr.sh ..."
$basedir/init-xrandr.sh &
echo "(Re)starting polybar(s) ..."
$basedir/polybar.sh &
#echo "Starting hotspot ..."
#sudo /usr/local/bin/apstarter &
echo "Calling hdd-manager ..."
$basedir/hdd-manager.sh "spotify" "gimp-2.8" "audacious" "dropbox" &
echo "Calling battery-warning ..."
$basedir/battery-warning.sh &

synclient TapButton1=1
