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

numlockx &

#bell
pactl upload-sample /usr/share/sounds/freedesktop/stereo/dialog-warning.oga x11-bell
pactl load-module module-x11-bell sample=x11-bell display=$DISPLAY

xset b 100

#subpixeling
rm -f ~/.config/fontconfig/fonts.conf/10-sub-pixel-*
ln -s /etc/fonts/conf.avail/10-sub-pixel-rgb.conf ~/.config/fontconfig/fonts.conf
fc-cache

#gnome keyring
dbus-update-activation-environment --systemd DISPLAY
eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

#Allow containers to access X
xhost +local:

#i3
exec i3

#i3 DEBUG
#exec $HOME/github/i3/x86_64-unknown-linux-gnu/i3 --shmlog-size=26214400

