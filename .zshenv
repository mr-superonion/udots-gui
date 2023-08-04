# set PATH so it includes user's private bin if it exists
if [ -d "/opt/cisco/anyconnect/bin/" ] ; then
    export PATH="/opt/cisco/anyconnect/bin/:$PATH"
fi

# SSH

# SSH agent
if [[ ! -f "$XDG_RUNTIME_DIR/ssh-agent.env" ]]; then
    ssh-agent -t 1h > "$XDG_RUNTIME_DIR/ssh-agent.env"
fi
if [[ ! -f "$SSH_AUTH_SOCK" ]]; then
    source "$XDG_RUNTIME_DIR/ssh-agent.env" >/dev/null
fi
export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass

# User PATH
export homeSys="$HOME/.local/"
export PATH="$homeSys/bin":$PATH
export PATH="$homeSys/xbin":$PATH

# User setup
export XDG_CONFIG_HOME="$HOME/.config/"

# LIB
export LIBRARY_PATH="$homeSys/lib":$LIBRARY_PATH
export LIBRARY_PATH="$homeSys/lib64":$LIBRARY_PATH

# LD_LID
export LD_LIBRARY_PATH="$homeSys/lib":$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$homeSys/lib64":$LD_LIBRARY_PATH

# User gcc header
export C_INCLUDE_PATH="$homeSys/include":$C_INCLUDE_PATH

# User g++ header
export CPLUS_INCLUDE_PATH="$homeSys/include":$CPLUS_INCLUDE_PATH

export CMAKE_ROOT="homeSys/share/cmake-3.14/"
export PKG_CONFIG_PATH="$homeSys/lib/pkgconfig/":$PKG_CONFIG_PATH
export PKG_CONFIG_PATH="$homeSys/lib64/pkgconfig/":$PKG_CONFIG_PATH

export GTK_IM_MODULE="fcitx"
export QT_IM_MODULE="fcitx"
export SDL_IM_MODULE="fcitx"
export XMODIFIERS=@im="fcitx"
