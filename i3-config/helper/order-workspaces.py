#!/usr/bin/env python3

import i3ipc
import time
import sys

SECONDARY_SCREEN = "eDP1"
FLIP_POINT = 6


def should_be_moved(i3, ws_num):
    if ws_num < FLIP_POINT:
        return False
    else:
        workspaces = i3.get_workspaces()
        for ws in workspaces:
            if ws.num == ws_num - 1:
                return ws.output == SECONDARY_SCREEN
        return True


def move_workspace(i3, ws_name, output=SECONDARY_SCREEN):
    i3.command('workspace "%s"' % ws_name)
    i3.command('move workspace to output "%s"' % output)


def on_workspace_rename(i3, event):
    if should_be_moved(i3, event.current.num):
        move_workspace(i3, event.current.name)


if __name__ == '__main__':
    time.sleep(0.2)
    i3 = i3ipc.Connection()

    primary_screen = ''
    for output in i3.get_outputs():
        if output['name'] == 'HDMI1' or output['name'] == 'VGA1':
            primary_screen = output['name']
            break

    if not primary_screen:
        sys.exit()

    current_focus = i3.get_tree().find_focused().workspace().name
    workspaces = []
    for ws in i3.get_workspaces():
        workspaces.append((ws.num, ws.name))
    workspaces.sort()

    move_remaining = False
    for i in range(len(workspaces)):
        if move_remaining or (workspaces[i][0] > FLIP_POINT and workspaces[i - 1][0] < workspaces[i][0] - 1):
            move_remaining = True
            move_workspace(i3, workspaces[i][1])
        else:
            move_workspace(i3, workspaces[i][1], primary_screen)
    i3.command('workspace "%s"' % current_focus)

    i3.on('workspace::rename', on_workspace_rename)
    i3.main()
