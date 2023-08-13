#!/bin/sh

# Key Mapping
[ -f ~/.config/X11/Xmodmap ] && xmodmap ~/.config/X11/Xmodmap
displaySetup
[ "$(which fcitx 2>/dev/null)" ] && fcitx -d & # input method
[ "$(which blueman-tray 2>/dev/null)" ] && blueman-applet & # bluetooth
[ "$(which nm-applet 2>/dev/null)" ] && nm-applet & # network
[ "$(which pasystray 2>/dev/null)" ] && pasystray & # volum control
[ "$(which polkit-dumb-agent 2>/dev/null)" ] && polkit-dumb-agent &

