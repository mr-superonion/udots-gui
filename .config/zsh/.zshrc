## .zshrc

shareDir="$homeSys/xshare/"
if [ -d "$shareDir" ]; then
    for script in $shareDir/*sh; do
        if [ -x "$script" -a ! -d "$script" ]; then
            . "$script"
        fi
    done
fi

# Default Software
export TERM="xterm"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"
export IMAGE="sxiv"
export OPENER="xdg-open"
export PAGER="less"
export WM="qtile"
export FILEMANAGER="pcmanfm"

export sysShell="usr/bin/zsh"
export docDir="$HOME/Documents/"
export paperDir="$docDir/Research/Papers/"

# Alias
source ~/.shell_aliases

