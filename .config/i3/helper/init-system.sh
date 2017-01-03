#!/bin/sh

BASEDIR=$(dirname "$0")
echo "Calling init-xrandr.sh ..."
$BASEDIR/init-xrandr.sh &
echo "Calling apstarter.sh ..."
sudo $BASEDIR/apstarter.sh &
