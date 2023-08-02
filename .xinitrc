#!/usr/bin/env sh
#
# ~/.xinitrc
#

eval $(ssh-agent)

[ "$(which fcitx 2>/dev/null)" ] && fcitx -d & # input method
[ "$(which thunar 2>/dev/null)" ] && thunar --daemon &  # file manager
[ "$(which blueman-tray 2>/dev/null)" ] && blueman-applet & # bluetooth
[ "$(which nm-applet 2>/dev/null)" ] && nm-applet & # network
[ "$(which pasystray 2>/dev/null)" ] && pasystray & # volum control


# Cursor speed
xset r rate 300 50

# Xresource
[ -f ~/.Xresources ] && xrdb -load ~/.Xresources

# Key Mapping
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

exec qtile start
