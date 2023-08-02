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

# Load Antigen
source ~/.antigen.zsh
# Load Antigen configurations
antigen init ~/.antigenrc

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
# Enable checking for (un)staged changes, enabling use of %u and %c
zstyle ':vcs_info:*' check-for-changes true
# Set custom strings for an unstaged vcs repo changes (*) and staged changes (+)
zstyle ':vcs_info:*' unstagedstr '*'
zstyle ':vcs_info:*' stagedstr '+'
zstyle ':vcs_info:git:*' formats '%F{yellow}(%b%u)'
precmd_vcs_info() { vcs_info }
precmd_functions+=( precmd_vcs_info )
setopt prompt_subst
RPROMPT=\$vcs_info_msg_0_
export PROMPT='%F{blue}[%c]%(?.%F{yellow} ➜ .%F{red} x )%f'

# export LS_COLORS='rs=0:di=36;04:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:'
export LS_COLORS="$(vivid generate one-dark)"
export ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=#435a63"
export ZSH_AUTOSUGGEST_STRATEGY=(completion history)

export CM_DEBUG=0
export CM_MAX_CLIPS=20

SABLE_AUTO_TITLE=true

bindkey -v
export KEYTIMEOUT=1

# VIM Key binding
# Better searching in command mode
bindkey -M vicmd '?' history-incremental-search-backward
bindkey -M vicmd '/' history-incremental-search-forward

# Beginning search with arrow keys
bindkey "^[OA" up-line-or-beginning-search
bindkey "^[OB" down-line-or-beginning-search
bindkey -M vicmd "k" up-line-or-beginning-search
bindkey -M vicmd "j" down-line-or-beginning-search
bindkey "^?" backward-delete-char

# Change cursor shape for different vi modes.
function zle-keymap-select {
  if [[ ${KEYMAP} == vicmd ]] ||
     [[ $1 = 'block' ]]; then
    echo -ne '\e[1 q'

  elif [[ ${KEYMAP} == main ]] ||
       [[ ${KEYMAP} == viins ]] ||
       [[ ${KEYMAP} = '' ]] ||
       [[ $1 = 'beam' ]]; then
    echo -ne '\e[5 q'
  fi
}
zle -N zle-keymap-select

zle-line-init() {
    zle -K viins # initiate `vi insert` as keymap (can be removed if `bindkey -V` has been set elsewhere)
    echo -ne "\e[5 q"
}
zle -N zle-line-init

# Use beam shape cursor on startup.
echo -ne '\e[5 q'
# Use beam shape cursor for each new prompt.
preexec() { echo -ne '\e[5 q' ;}

# history
unsetopt share_history
setopt EXTENDED_HISTORY
setopt HIST_EXPIRE_DUPS_FIRST
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_ALL_DUPS
setopt HIST_IGNORE_SPACE
setopt HIST_FIND_NO_DUPS
setopt HIST_SAVE_NO_DUPS
setopt HIST_BEEP
