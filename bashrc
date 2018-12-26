##################################
#                                #
#      BASH Functions            #
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

function DockerImagesCleanAll()
{
   docker images | awk 'NR>1 {print $3}' | xargs -L 1 -t docker rmi -f
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
alias docker-images-cleanall='DockerImagesCleanAll'

# path to $HOME/bin if it exists
if [[ "$PATH" != *"$HOME/bin"* ]]; then
   if [ -d $HOME/bin ]; then
      export PATH=$PATH:$HOME/bin;
   fi
fi

# path to gcloud if it exists
if [[ "$PATH" != *"google-cloud-sdk"* ]]; then
   if [ -d $HOME/bin/google-cloud-sdk/bin ]; then
      export PATH=$PATH:$HOME/bin/google-cloud-sdk/bin;
   fi
fi

# path to the packer
if [[ "$PATH" != *"packer"* ]]; then
   if [ -d $HOME/packer ]; then
      export PATH=$PATH:$HOME/packer;
   fi
fi

# path to the terraform
if [[ "$PATH" != *"terraform"* ]]; then
   if [ -d $HOME/terraform ]; then
      export PATH=$PATH:$HOME/terraform;
   fi
fi

# path to the otto
if [[ "$PATH" != *"otto"* ]]; then
   if [ -d $HOME/otto ]; then
      export PATH=$PATH:$HOME/otto;
   fi
fi

# add path to go if it is installed
if [ -f /usr/local/go/bin/go ]; then
   export PATH=$PATH:/usr/local/go/bin;
   if [ -d $HOME/go-workspace ]; then
      export GOPATH=$HOME/go-workspace
   fi
fi

# add path to vagrant if it is installed
if [ -f /usr/local/bin/vagrant ]; then
   export VAGRANT_DEFAULT_PROVIDER=virtualbox
fi

# check if Mac & set path to vmware fusion
if [ "$(uname)" == "Darwin" ]; then
   if [[ "$PATH" != *"/Applications/VMware Fusion.app/Contents/Library"* ]]; then
      if [ -d "/Applications/VMware Fusion.app/Contents/Library" ]; then
         export PATH=$PATH:"/Applications/VMware Fusion.app/Contents/Library"
      fi
   fi
fi

##############################################
#                                            #
#      Python virtualenvwrapper setup        #
#                                            #
##############################################

if [ -f /usr/local/bin/virtualenvwrapper.sh ]; then
   if [ -d $HOME/workspace/ ]; then
      export PROJECT_HOME=$HOME/workspace
   fi
   if [ -d $HOME/workspace/.virtualenvs ]; then
      export WORKON_HOME=$HOME/workspace/.virtualenvs
   fi
      source /usr/local/bin/virtualenvwrapper.sh
fi
