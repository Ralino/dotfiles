#!/bin/sh

basedir=$(dirname "$0")
echo "Calling init-xrandr.sh ..."
$basedir/init-xrandr.sh &
echo "Calling apstarter.sh ..."
sudo /usr/local/bin/apstarter &
echo "Reverting hdd-manager ..."
pkill -SIGUSR1 "hdd-manager.sh"
echo "Reverting battery-warning ..."
pkill -SIGUSR1 "battery-warning.sh"
