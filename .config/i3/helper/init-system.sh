#!/bin/sh

basedir=$(dirname "$0")
echo "Calling init-xrandr.sh ..."
$basedir/init-xrandr.sh &
echo "Calling apstarter.sh ..."
sudo /usr/local/bin/apstarter &
echo "Calling hdd-manager ..."
$basedir/hdd-manager.sh "spotify" "gimp-2.8" "audacious" "ranger" "dropbox" &
echo "Calling battery-warning ..."
$basedir/battery-warning.sh &
