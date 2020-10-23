#!/bin/sh

[ "$(which picom 2>/dev/null)" ] && picom &
[ "$(which blueberry-tray 2>/dev/null)" ] && blueberry-tray &
[ "$(which blueman-tray 2>/dev/null)" ] && blueman-tray &
[ "$(which nm-applet 2>/dev/null)" ] && nm-applet &
updateWeather
displaySetup
