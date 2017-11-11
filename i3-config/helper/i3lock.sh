#!/bin/bash

revert() {
 xset dpms 0 0 0
}

basedir=$(dirname "$0")

if [ -f $basedir/.i3lock-pid ] && [ $(pgrep -x "i3lock.sh") == $(cat $basedir/.i3lock-pid) ]
then
    echo "i3lock already running."
    exit 1
fi

echo $$ > $basedir/.i3lock-pid

if [ -z "$1" ]; then
    i3lock -n -e -f -i $($basedir/pick-wallpaper.sh) -t
else
    if [ "$1" == "-dpms" ]; then
        trap revert SIGHUP SIGINT SIGTERM
        xset +dpms dpms 5 5 5
        i3lock -n -e -f -i $($basedir/pick-wallpaper.sh) -t
        revert
    else
        echo "Unknown argument: $1"
        exit 1
    fi
fi
rm $basedir/.i3lock-pid

echo "Calling init-system.sh ..."
$basedir/init-system.sh
