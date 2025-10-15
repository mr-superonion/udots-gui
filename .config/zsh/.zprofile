# Start the Sway Wayland session on the first virtual terminal

shareDir="$HOME/.local/xshare/"
if [ -d "$shareDir" ]; then
    for script in "$shareDir"/*sh; do
        [ -e "$script" ] || continue
        # shellcheck disable=SC1090
        . "$script"
    done
fi

if [ -z "${WAYLAND_DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
    export XDG_SESSION_CLASS="user"
    export XDG_SESSION_DESKTOP="sway"
    export XDG_SESSION_TYPE="wayland"
    exec dbus-run-session sway
fi
