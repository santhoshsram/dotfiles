##################################
#											#
#		BASH Enviroment SETUP		#
#		User: santhosh					#
#											#
##################################

Machine=$(uname)
if [ "$Machine"="Linux" ]; then
	export PATH=$PATH:/build/apps/bin:~/bin:/dbc/pa-dbc1123/santosh/vmware-git-tools/bin:/mystorage/perftools/scripts
	# export LD_LIBRARY_PATH=/usr/local/staf/lib/perl58:/usr/local/staf/lib:/usr/local/vet/lib:/usr/local/automation/framework/lib
	export LD_LIBRARY_PATH=
   #export PYTHONPATH=$PYTHONPATH:/mystorage/perftools/libs
elif ["$Machine"="Darwin"]; then
	export PATH=$PATH:/build/apps/bin
fi

function GIT_BRANCH_PROMPT()
{
   GIT_BRANCH=$(git branch 2>/dev/null| sed -n "/^\*/s/^\* //p")
   if [[ "$GIT_BRANCH" != "" ]]; then
      echo " ($GIT_BRANCH)"
   else
      echo ""
   fi
}
export PS1_1LINE="[\u@\h \W]$ "
export PS1_2LINES="[\u@\h \w]\n$ "
#export PS1='[\u@\h \w`GIT_BRANCH_PROMPT`]\n$ '
export PS1='\[\033[01;37m[\033[01;32m\]\u@\h\[\033[01;34m\] \w`GIT_BRANCH_PROMPT`\[\033[01;37m\]]\n\$ \[\033[00m\]'
#export LS_COLORS='no=00:fi=00:di=01;34:ln=01;35:pi=40;33:so=01;35:bd=40;33;01:cd=40;33;01:or=01;05;37;41:mi=01;05;37;41:ex=00;31:*.cmd=01;32:*.exe=01;32:*.com=01;32:*.btm=01;32:*.bat=01;32:*.sh=01;32:*.csh=01;32:*.tar=01;31:*.tgz=01;31:*.arj=01;31:*.taz=01;31:*.lzh=01;31:*.zip=01;31:*.z=01;31:*.Z=01;31:*.gz=01;31:*.bz2=01;31:*.bz=01;31:*.tz=01;31:*.rpm=01;31:*.cpio=01;31:*.jpg=01;35:*.gif=01;35:*.bmp=01;35:*.xbm=01;35:*.xpm=01;35:*.png=01;35:*.tif=01;35:';

export DBC_HOME=/dbc/pa-dbc1123/santosh
export NET_HOME=/mts/home5/santosh
export TCROOT=/build/toolchain
export P4CONFIG=.p4config
export P4EDITOR='/usr/bin/vim -u ~/.vimrc'
export P4MERGE='/bldmnt/trees/bin/p4tkmerge'
export EDITOR=vim
#export CLASSPATH=$CLASSPATH:/share/stafsdk/lib/lib.jar:. #This is needed for ws build to work properly when building java based sources
export ftp_proxy=http://proxy.vmware.com:3128
export http_proxy=http://proxy.vmware.com:3128
export TERM=xterm
#if [ -z "$DISPLAY" ]; then
#   export DISPLAY=:0
#fi


export ESX="santosh-esx1.eng.vmware.com"
##################################
#											#
#		BASH Command Aliases			#
#											#
##################################

#alias ls='ls'
alias ls='ls --color=auto'
alias ll='ls -lh'
alias gvmk='cd /dbc/pa-dbc1123/santosh/santosh-git-vmkmain/bora'
alias gvmk2='cd /dbc/pa-dbc1123/santosh/santosh-git-vmkmain-2/bora'
alias gp2013='cd /dbc/pa-dbc1123/santosh/santosh-git-prod2013/bora'
alias gp2013s='cd /dbc/pa-dbc1123/santosh/santosh-git-prod2013-stage/bora'
alias mydbc='cd /dbc/pa-dbc1123/santosh'
alias myesx='ssh root@$ESX'
alias lscons='/usr/bin/scons'
alias pd='pushd'
alias p='popd'


##################################
#											#
#		Cool Scripts from Randy		#
#											#
##################################
alias fc='find . -name "*.c" -print0 | xargs -0 fgrep -n '
alias fh='find . -name "*.h" -print0 | xargs -0 fgrep -n '
alias fch='find . -name "*.[ch]" -print0 | xargs -0 fgrep -n '
alias fcpp='find . -name "*.cpp" -print0 | xargs -0 fgrep -n '
alias fasm='find . -iname "*.asm" -print0 | xargs -0 fgrep -n '
alias fdsc='find . -iname "*.dsc" -print0 | xargs -0 fgrep -in '
alias finf='find . -iname "*.inf" -print0 | xargs -0 fgrep -in '

##################################
#											#
#		Nimbus Env Vars   			#
#											#
##################################
NIMBUS=santosh-cloud1
NIMBUS_ENV_FILE=/mts/home5/santosh/confs/santosh-nimbus-config


##################################
#											#
#		Some terminal settings		#
#											#
##################################
