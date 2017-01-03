#!/bin/sh

revert() {
 xset dpms 0 0 0
}

BASEDIR=$(dirname "$0")

if [ -z $1 ]; then
    i3lock -n -e -f -i $($BASEDIR/pick-wallpaper.sh) -t
else
    if [ $1 == "-dpms" ]; then
        trap revert SIGHUP SIGINT SIGTERM
        xset +dpms dpms 5 5 5
        i3lock -n -e -f -i $($BASEDIR/pick-wallpaper.sh) -t
        revert
    else
        echo "Unknown argument: $1"
        exit 1
    fi
fi

echo "Calling init-system.sh ..."
$BASEDIR/init-system.sh
