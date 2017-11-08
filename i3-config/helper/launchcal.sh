#!/bin/sh

if (( $# != 3 )); then
    echo "Usage: launchcal.sh %Y %m %e"
    exit 1
fi


URL="https://calendar.google.com/calendar/render#main_7%7Cmonth-3+"
target=0

let "target = ($1 - 1970) * 512 + $2 * 32 + $3"

chromium -app=$URL$target+$target+$target
