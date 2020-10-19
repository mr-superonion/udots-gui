# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and functions

# View of shell
export PS1='[\W] \h% '

# Directory of important files
export master_ipmu="xiangchong.li@master.ipmu.jp"
export gfarm_ipmu="xiangchong.li@gfarm.ipmu.jp"
export gw_ipmu="xiangchong.li@192.168.156.68"
export member_ipmu="xiangchong.li@157.82.236.20"

export dellJZ_sjtu="lxc@202.120.13.66"

# User PATH
export homeSys="/home/xiangchong/superonionYoga/"
export PATH="$homeSys/bin":$PATH


#Vim
set -o vi # vi at command line
export EDITOR=vim

#ls
ls --color=al > /dev/null 2>&1 && alias ls='ls -F --color=al' || alias ls='ls -G'

