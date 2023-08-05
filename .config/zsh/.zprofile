# language
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8

# Start X11
if [ -z "${DISPLAY}" ] && [ "${XDG_VTNR}" -eq 1 ]; then
  exec startx ~/.config/X11/xinitrc
fi

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
