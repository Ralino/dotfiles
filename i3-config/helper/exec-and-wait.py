#!/usr/bin/env python3

import i3ipc
import time
import sys
import subprocess

if len(sys.argv) < 2:
    print("Expected at least one argument.")
    sys.exit(1)

i3 = i3ipc.Connection()

executable = sys.argv[1]
window_class = executable.lower()
if len(sys.argv) > 2:
    window_class = sys.argv[2].lower()

subprocess.Popen(executable)

time_start = time.process_time()
win = i3.get_tree().find_focused().window_class.lower()
while win != window_class:
    win = i3.get_tree().find_focused().window_class.lower()
    if time.process_time() - time_start > 2.0:
        print("Timeout!")
        sys.exit(2)

sys.exit(0)
