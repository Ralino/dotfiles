#!/usr/bin/env python3

import i3ipc
import re


termite_map = [
    (".*\\(.*iboss_ws/src/iboss/.*\\) - VIM$", "iBOSS Vim"),
    (".* - VIM$", "Vim"),
    ("^.+?@nextcloud.*", "Nexcloud ssh"),
    ("^.+?@foxlair.*", "foxlair ssh"),
    (".* - iBOSS$", "iBOSS Terminal"),
    (".* - Ubuntu$", "Ubuntu Terminal"),
    (".* - Kamaro$", "Kamaro Terminal"),
    ("^root@fieldfox.*", "Root Terminal"),
    ("^ranger:.*", "Ranger"),
    # default
    "Terminal"
]

# Precompile regex
temp_list = []
for i in range(len(termite_map) - 1):
    temp_list.append((re.compile(termite_map[i][0]), termite_map[i][1]))
temp_list.append((re.compile('.*'), termite_map[len(termite_map) - 1]))
termite_map = temp_list

class_map = {
    "Nightly": "Browser",
    "Firefox": "Browser",
    "jetbrains-pycharm-ce": "PyCharm",
    "whats-app-nativefier-7bbd2c": "WhatsApp",
    "Termite": termite_map,
    "Polybar": "",
    "Cellwriter": "",
    "gnome-pie-211": "",
    "gnome-pie-481": "",
    "gnome-pie-552": "",
    "gnome-pie-575": "",
    "gnome-pie-856": "",
    "gnome-pie-471": ""
}


def get_ws_name(con):
    if not con.window:
        return "Empty"
    if con.name == "scratchpad":
        return ""
    if con.window_class not in class_map:
        return con.window_class

    mapped_name = class_map[con.window_class]
    if type(mapped_name) != str:
        for pair in mapped_name:
            if pair[0].fullmatch(con.name):
                return pair[1]
        # Should not get here, make aware if it does
        return "DEFAULTMISSING"
    else:
        return mapped_name


def on_focus_change(i3, e):
    focused = i3.get_tree().find_focused()
    set_workspace_name(focused.workspace(), get_ws_name(focused))


def set_workspace_name(ws, new_name):
    if new_name != "" and ws.name != "{0}: {1} ".format(ws.num, new_name):
        i3.command('rename workspace "{0}" to "{1}: {2} "'.format(ws.name, ws.num, new_name))


i3 = i3ipc.Connection()

i3.on('workspace::focus', on_focus_change)
i3.on('window::focus', on_focus_change)
i3.on('window::title', on_focus_change)

i3.main()
