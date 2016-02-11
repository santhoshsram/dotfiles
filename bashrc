##################################
#                                #
#      BASH Enviroment SETUP     #
#                                #
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
#                                #
#      BASH Command Aliases      #
#                                #
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

# path to the terraform
if [[ "$PATH" != *"terraform"* ]]; then
   if [ -d $HOME/terraform ]; then
      export PATH=$PATH:$HOME/terraform;
   fi
fi
