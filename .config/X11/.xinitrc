xset r rate 300 50 &
xrdb -load ~/.config/X11/Xresources &
sleep 3 && xmodmap ~/.config/X11/Xmodmap &
exec qtile start
