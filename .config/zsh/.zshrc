## .zshrc

plugins=(git ssh-agent)

## autocomplete
# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending
autoload -Uz compinit
compinit
compdef vim='nvim'
compdef config='git'
compinit -d "$XDG_CACHE_HOME"/zsh/zcompdump-"$ZSH_VERSION"

setopt complete_aliases

source "$XDG_CONFIG_HOME"/zsh/zvi
source "$XDG_CONFIG_HOME"/zsh/zprompt
source "$XDG_CONFIG_HOME"/zsh/zcolor
source "$XDG_CONFIG_HOME"/zsh/zls
source "$XDG_CONFIG_HOME"/zsh/zhistory
source "$XDG_CONFIG_HOME"/zsh/zalias

# Default Software
# export TERM="xterm"
export EDITOR="nvim"
export READER="zathura"
export BROWSER="brave"
export IMAGE="sxiv"
export OPENER="xdg-open"
export PAGER="less"
export WM="qtile"
export FILEMANAGER="thunar"

export sysShell="usr/bin/zsh"
export docDir="$HOME/Documents/"
export paperDir="$docDir/Research/Papers/"
