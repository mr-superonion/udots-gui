# language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Set PATH so it includes user's private bin if it exists
if [ -d "/opt/cisco/anyconnect/bin/" ] ; then
    export PATH="/opt/cisco/anyconnect/bin/:$PATH"
fi

# XDG setup
export XDG_CONFIG_HOME="$HOME/.config/"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"
export XDG_CACHE_HOME="$HOME/.cache"
export CUDA_CACHE_PATH="$XDG_CACHE_HOME"/nv
export GNUPGHOME="$XDG_DATA_HOME"/gnupg
export GTK2_RC_FILES="$XDG_CONFIG_HOME"/gtk-2.0/gtk
export MYPY_CACHE_DIR="$XDG_CACHE_HOME"/mypy
export _JAVA_OPTIONS=-Djava.util.prefs.userRoot="$XDG_CONFIG_HOME"/java
export PYTHONSTARTUP="$XDG_CONFIG_HOME"/python/pythonrc
export TEXMFVAR="$XDG_CACHE_HOME"/texlive/texmf-var
export IPYTHONDIR="$XDG_CONFIG_HOME"/ipython
export LESSHISTFILE="$XDG_CACHE_HOME/less/history"
export ICEAUTHORITY="$XDG_CACHE_HOME"/ICEauthority
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME"/npm/npmrc
export JUPYTER_CONFIG_DIR="$XDG_CONFIG_HOME"/jupyter
export SSB_HOME="$XDG_DATA_HOME"/zoom
export WINEPREFIX="$XDG_DATA_HOME"/wine
export ZDOTDIR="$HOME"/.config/zsh
export XAUTHORITY="$XDG_RUNTIME_DIR"/Xauthority


# SSH agent
if [ "$SSH_AUTH_SOCK" = "" ]; then
    eval `ssh-agent -s`
fi
# export SSH_ASKPASS=/usr/lib/ssh/x11-ssh-askpass

# User PATH
export homeSys="$HOME/.local/"
export PATH="$homeSys/bin":$PATH
export PATH="$homeSys/xbin":$PATH

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
