#!/bin/sh

init_manager() {
    last=""
    sudo hdd-sleep on
}

if [ "$(pgrep -x "hdd-manager.sh")" != "$$" ]; then
    echo "hdd-manager already running!
Sending init-signal..."
    pkill -SIGUSR1 -x "hdd-manager.sh"
    exit 1
fi

trap init_manager SIGUSR1

init_manager

while [ ! ]; do
    current=""
    for process do
        if [ "$(pgrep -x "$process")" ]; then
            current="true"
        fi
    done

    if [ "$last" != "$current" ]; then
        if [ "$current" ]; then
            sudo hdd-sleep off
        else
            sudo hdd-sleep on
        fi
    fi
    last=$current

    sleep 55
done
