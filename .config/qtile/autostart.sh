#!/bin/sh


[ "$(which picom 2>/dev/null)" ] && picom --experimental-backends &
[ "$(which blueberry-tray 2>/dev/null)" ] && blueberry-tray &
[ "$(which blueman-tray 2>/dev/null)" ] && blueman-tray &
[ "$(which nm-applet 2>/dev/null)" ] && nm-applet &
[ "$(which pasystray 2>/dev/null)" ] && pasystray &

#updateWeather
displaySetup
