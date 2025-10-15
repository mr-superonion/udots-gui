#!/bin/sh
# Sway is a Wayland compositor and does not require an X11 session.
# This script is kept for compatibility so that running `startx`
# launches Sway through dbus-run-session.

exec dbus-run-session sway
