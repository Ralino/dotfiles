#!/bin/sh

init_manager() {
    last=""
    sudo hdd-sleep on
}

trap init_manager SIGUSR1

init_manager

while [ ! ]; do
    current=""
    for process do
        if [ $(pgrep -x "$process") ]; then
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
