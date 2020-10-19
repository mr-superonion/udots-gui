## .zshrc
## . ~/.profile

# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"
source $ZSH/oh-my-zsh.sh
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes
ZSH_THEME="robbyrussell"

#LD_LID
export LD_LIBRARY_PATH="$homeSys/lib":$LD_LIBRARY_PATH
export LD_LIBRARY_PATH="$homeSys/lib64":$LD_LIBRARY_PATH

export LS_COLORS='rs=0:di=36;04:ln=38;5;51:mh=44;38;5;15:pi=40;38;5;11:so=38;5;13:do=38;5;5:bd=48;5;232;38;5;11:cd=48;5;232;38;5;3:or=48;5;232;38;5;9:mi=05;48;5;232;38;5;15:su=48;5;196;38;5;15:sg=48;5;11;38;5;16:ca=48;5;196;38;5;226:tw=48;5;10;38;5;16:ow=48;5;10;38;5;21:st=48;5;21;38;5;15:ex=38;5;34:'
export PS1='%{$fg[blue]%} %(?:%{%}➜ :%{%}➜ ) %c%{$reset_color%} '

export CM_DEBUG=0
export CM_MAX_CLIPS=20

SABLE_AUTO_TITLE=true

source ~/.zsh_aliases

plugins=()
if [[ $DISPLAY ]]; then
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
fi

# history
unsetopt share_history
