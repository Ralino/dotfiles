#!/bin/sh
#
# Make this a daemon or something, so it does not poll

warn_nr=0
basedir=$(dirname "$0")

revert() {
    warn_nr=0
}

trap revert SIGUSR1

while [ ! ]; do
    batstatus=$(acpi -b)
    remaining=$(echo "$batstatus" | grep -o " [[:digit:]]*%" | grep -o "[[:digit:]]*")

    if [ "$(echo "$batstatus" | grep "Discharging")" ]; then
        if (($remaining < 5 && $warn_nr < 2)); then
            zenity --title="Ladekabel anschließen" --text="Nur noch $remaining% des Akkus verbleiben!\nLadekabel jetzt anschließen oder herunterfahren." --warning
            warn_nr=2
        else if (($remaining < 20 && $warn_nr < 1)); then
                zenity --title="Ladekabel anschließen" --text="Nur noch $remaining% des Akkus verbleiben!" --timeout=10 --warning
                warn_nr=1
            fi
        fi
    else if [ "$(echo "$batstatus" | grep "Charging")" ] && (($remaining > 20)); then
            warn_nr=0
        fi
    fi

    sleep 1m
done
