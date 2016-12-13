#!/bin/bash
#
# Might get very slow with large first argument. Use with care.

num=0
files="$HOME/wallpaper/*.png"

if [ -z $1 ]; then
    requested=1
else
    requested=$1
fi

for img in $files; do
    fileArray[$num]=$img
    let "num++"
done

if (( $num + 1 < $requested )); then
    echo "Not enough pictures to satisfy request."
    exit 1
fi

for req in `seq $requested`; do
    result[$req]="NULL"
    while [ ${result[$req]} == "NULL" ]; do
        rand=$RANDOM
        let "rand %= $num"
        result[$req]=${fileArray[$rand]}
        for prev in `seq $req`; do
            if (( $prev != $req )); then
                if [ ${result[$prev]} == ${result[$req]} ]; then
                    result[$req]="NULL"
                fi
            fi
        done
    done
    echo -n "${result[$req]} "
done
