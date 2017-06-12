#!/usr/bin/env python3

import i3ipc
import re

i3 = i3ipc.Connection()

def get_ws_name(con):
    if not con.window:
        return "Empty"
    else:
        if con.window_class == "URxvt":
            return get_urxvt_name(con)
        elif con.window_class == "Chromium":
            return get_chromium_name(con)
        else:
            if (con.window_class == "Pavucontrol" and con.type == "floating_con"
                    or con.window_class == "gsimplecal"):
                return ""
            return con.window_class

def get_urxvt_name(con):
    #TODO ranger
    #TODO update when name changes
    if con.name == "scratchpad":
        return ""
    if con.name.endswith(" - VIM"):
        if con.name.startswith("stdin"):
            return "Vimpager"
        else:
            return "Vim"
    elif con.name.startswith("kamaro@nextcloud") or con.name.startswith("root@nextcloud"):
        return "SSH Nextcloud"
    elif con.name.startswith("kamaro@kamaro-beteigeuze"):
        return "SSH Beteigeuze"
    elif con.name.startswith("root@foxlair"):
        return "Root Terminal"
    else:
        flag = re.search("(?<= - )\w+$", con.name)
        if flag:
            if (flag.group(0) == "ROS" or flag.group(0) == "BTR"
                                      or flag.group(0) == "iBOSS"):
                return flag.group(0) + " Terminal"
            else:
                return flag.group(0)
        else:
            return "Terminal"

def get_chromium_name(con):
    if con.name.startswith("WhatsApp"):
        return "WhatsApp"
    elif con.name.startswith("Signal"):
        return "Signal"
    elif con.name.startswith("Google Kalender"):
        return "Calendar"
    else:
        return "Chromium"

def on_focus_change(i3, e):
   focused = i3.get_tree().find_focused()
   set_workspace_name(focused.workspace(), get_ws_name(focused))

def set_workspace_name(ws, new_name):
    if new_name != "" and ws.name != "{0}: {1} ".format(ws.num, new_name):
        i3.command('rename workspace "{0}" to "{1}: {2} "'.format(ws.name, ws.num, new_name))

i3.on('workspace::focus', on_focus_change)
i3.on('window::focus', on_focus_change)
i3.on('window::title', on_focus_change)

i3.main()
