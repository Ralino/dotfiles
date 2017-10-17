#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

#twm &
#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login

numlockx &

#bell
pactl upload-sample /usr/share/sounds/freedesktop/stereo/dialog-warning.oga x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY

xset b 100

#xmodmap -e "keycode 91 mod2 = KP_Delete period"

#i3
exec i3

#i3 DEBUG
#exec $HOME/github/i3/x86_64-unknown-linux-gnu/i3 --shmlog-size=26214400

