#!/usr/bin/env sh
#
# ~/.xinitrc
#

ERRFILE="$XDG_CACHE_HOME"/X11/xsession-errors

# Cursor speed
xset r rate 300 50

# Xresource
xrdb -load ~/.config/X11/Xresources

# Key Mapping
xmodmap ~/.config/X11/Xmodmap

# start window manager
exec qtile start
# qtile start -b wayland
