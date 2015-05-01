##################################
#											#
#		BASH Enviroment SETUP		#
#		User: santhosh					#
#											#
##################################


function GIT_BRANCH_PROMPT()
{
   GIT_BRANCH=$(git branch 2>/dev/null| sed -n "/^\*/s/^\* //p")
   if [[ "$GIT_BRANCH" != "" ]]; then
      echo " ($GIT_BRANCH)"
   else
      echo ""
   fi
}

Machine=$(uname)

export PS1='\[\033[01;37m[\033[01;32m\]\u@\h\[\033[01;34m\] \w`GIT_BRANCH_PROMPT`\[\033[01;37m\]]\n\$ \[\033[00m\]'
export EDITOR=vim
export TERM=xterm

##################################
#											#
#		BASH Command Aliases			#
#											#
##################################

if [ "$Machine" = "Linux" ]; then
   alias ls='ls --color=auto'
   alias ll='ls -lh'
elif [ "$Machine" = "Darwin" ]; then
   alias ll='ls -l'
fi
alias ll='ls -lh'
alias pd='pushd'
alias p='popd'
alias scrls='screen -ls'
alias scr-ctl='screen -A -d -R'


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
