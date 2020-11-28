#!/usr/bin/env sh
#
# ~/.xinitrc
#

# Executed by startx
[ -f ~/.xprofile ] && . ~/.xprofile

# Xresource
[ -f ~/.Xresources ] && xrdb -load $HOME ~/.Xresources

# Key Mapping
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap
