#!/bin/bash

revert() {
    warn_nr=0
}

if [ "$(pgrep -x "battery-warning")" != "$$" ]; then
    echo "battery-warning already running!
Sending revert-signal..."
    pkill -SIGUSR1 -x "battery-warning"
    exit 1
fi

warn_nr=0

trap revert SIGUSR1

while [ ! ]; do
    # acpi sometimes wrongly sees two batteries. Battery 1 is the correct one in that case
    batstatus=$(acpi -b | grep "Battery 1:")
    if [ -z "$batstatus" ]; then
        batstatus=$(acpi -b | grep "Battery 0:")
    fi
    remaining=$(echo "$batstatus" | grep -o " [[:digit:]]*%" | grep -o "[[:digit:]]*")

    if [ "$(echo "$batstatus" | grep "Discharging")" ]; then
        if (($remaining < 6 && $warn_nr < 3)); then
            zenity --title="Ladekabel anschließen" \
                   --text="Nur noch $remaining% des Akkus verbleiben!\nLadekabel jetzt anschließen oder herunterfahren." \
                   --warning
            warn_nr=3
        else
          if (($remaining < 21 && $warn_nr < 2)); then
            notify-send -u critical "Ladekabel anschließen" "Nur noch $remaining% des Akkus verbleiben!"
            warn_nr=2
          else
            if (($remaining < 51 && $warn_nr < 1)); then
              notify-send -u normal "Ladezustand" "Noch $remaining% des Akkus verbleiben"
              warn_nr=1
            fi
          fi
        fi
      else if [ "$(echo "$batstatus" | grep "Charging")" ] && (($remaining > 20)); then
        warn_nr=0
      fi
    fi

    sleep 1m
done
