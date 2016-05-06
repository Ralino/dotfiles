#!/usr/bin/env python

import i3ipc
import re
import os
import subprocess

i3 = i3ipc.Connection()

focused = i3.get_tree().find_focused()
directory = ''

if focused.window_class == 'Terminator':
    if focused.name[-5:] == '- VIM':
        directory = re.match(".+\((.+?)\)", focused.name).group(1)
    else:
        directory = re.match(".+:(.+)", focused.name).group(1)

print(directory)

if os.path.isdir(os.path.expanduser(directory)):
    i3.command("exec terminator --working-directory='" + directory + "'")
else:
    print("Failed to retrieve a valid dir-path, starting terminator with default instead.")
    i3.command('exec terminator')
