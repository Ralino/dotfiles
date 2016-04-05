#!/bin/bash

amixer -q sset Master toggle
kill -SIGRTMIN+10 $(pidof i3blocks)
