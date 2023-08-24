xset r rate 300 50 &
xrdb -load ~/.config/X11/Xresources &
xmodmap ~/.config/X11/Xmodmap &
exec qtile start
