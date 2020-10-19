#!/usr/bin/env sh
#
# ~/.xinitrc
#

# Executed by startx
[ -f ~/.xprofile ] && . ~/.xprofile

# Xresource
[ -f ~/.Xresources ] && xrdb -merge -I$HOME ~/.Xresources

# Key Mapping
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

