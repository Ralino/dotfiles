#!/usr/bin/env python3

import i3ipc
import sys

i3 = i3ipc.Connection()

current_workspaces = i3.get_workspaces()
next_ws_nr = 1
for workspace in current_workspaces:
    if workspace['num'] == next_ws_nr:
        next_ws_nr = next_ws_nr + 1
        if next_ws_nr == 11:
            sys.exit(1)
    else:
        break

i3.command('workspace number {0}'.format(next_ws_nr))
