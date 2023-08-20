# # Start X11

shareDir="$HOME/Documents/Share/"
if [ -d "$shareDir" ]; then
    for script in $shareDir/*sh; do
        source "$script"
    done
fi

if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    export XDG_SESSION_CLASS="user"
    export XDG_SESSION_DESKTOP="qtile"
    export XDG_SESSION_TYPE="x11"
    exec startx ~/.config/X11/.xinitrc
fi

