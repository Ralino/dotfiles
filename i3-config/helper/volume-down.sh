#!/bin/bash

amixer -q sset Master 2%- unmute
kill -SIGRTMIN+10 $(pidof i3blocks)
