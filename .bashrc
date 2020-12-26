# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# View of shell
export PS1='[\W] \h% '

# Directory of important files

#Vim
set -o vi # vi at command line

#ls
ls --color=al > /dev/null 2>&1 && alias ls='ls -F --color=al' || alias ls='ls -G'
