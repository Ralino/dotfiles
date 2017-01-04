#!/bin/sh
#
# Make this a daemon or something, so it does not poll

WARN_NR=0

while [ ! ]; do
    BATSTATUS=$(acpi -b)
    REMAINING=$(echo "$BATSTATUS" | grep -o " [[:digit:]]*%" | grep -o "[[:digit:]]*")

    if [ "$(echo "$BATSTATUS" | grep "Discharging")" ]; then
        if (($REMAINING < 5 && $WARN_NR < 2)); then
            zenity --title="Ladekabel anschließen" --text="Nur noch $REMAINING% des Akkus verbleiben!\nLadekabel jetzt anschließen oder herunterfahren." --timeout=10 --warning
            WARN_NR=2
        else if (($REMAINING < 20 && $WARN_NR < 1)); then
                zenity --title="Ladekabel anschließen" --text="Nur noch $REMAINING% des Akkus verbleiben!" --timeout=10 --warning
                WARN_NR=1
            fi
        fi
    fi

    sleep 1m
done
