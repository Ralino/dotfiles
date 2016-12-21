#!/usr/bin/env python3

import sys
import subprocess

if len(sys.argv) != 4:
    sys.exit(1)

year  = int(sys.argv[1]) # %Y
month = int(sys.argv[2]) # %m
day   = int(sys.argv[3]) # %d

target_day = (year - 1970) * 512 + month * 32 + day

url = "https://calendar.google.com/calendar/render#main_7%7Cweek-2+"
url += str(target_day) + "+" + str(target_day) + "+" + str(target_day)

subprocess.Popen(["chromium", "-app=" + url])
