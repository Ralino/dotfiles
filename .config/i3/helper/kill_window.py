#!/usr/bin/env python

import i3ipc

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()


if focused.window_class == 'Keepassx2':
    i3.command("exec --no-startup-id xdotool search --maxdepth 2 --class keepassx2 windowunmap")
else:
    i3.command("kill")
