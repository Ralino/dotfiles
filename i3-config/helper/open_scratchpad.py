#!/usr/bin/env python3

import i3ipc
import time
import sys
import subprocess
import shlex

i3 = i3ipc.Connection()

scrpad = i3.get_tree().find_named('^scratchpad$')

if scrpad == []:
    subprocess.Popen(shlex.split('termite -t scratchpad -e \'bash -c "tmux new -A -s spad"\''));
    temp = []
    time_start = time.process_time()
    while temp == []:
        temp = i3.get_tree().find_named('^scratchpad$')
        if time.process_time() - time_start > 2.0:
            sys.exit(1)
        #TODO test timeout
    sp_window = temp[0]
    sp_window.command("move scratchpad")

i3.command("scratchpad show")
