#!/usr/bin/env python3

import i3ipc
import subprocess

for win in i3ipc.Connection().get_tree().leaves():
    subprocess.run(["xprop", "-id", str(win.window), "-remove", "_NET_WM_WINDOW_OPACITY"])
