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

export PS1='\[\033[01;37m\][\[\033[01;32m\]\u@\h \[\033[01;34m\]\w`GIT_BRANCH_PROMPT` \[\033[02;31m\]<\D{%F %T}>\[\033[00;37m\]\[\033[01;37m\]]\n$ \[\033[00m\]'
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

# add path to brew if it is installed
if [ -d /opt/homebrew/bin ]; then
   export PATH=/opt/homebrew/bin:$PATH
fi

# add path to brew if it is installed
if [ -d /opt/homebrew/sbin ]; then
   export PATH=/opt/homebrew/sbin:$PATH
fi

## Node - Node enVironment Manager
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

## RVB - Ruby enVironment Manager
[[ -r $rvm_path/scripts/completion ]] && . $rvm_path/scripts/completion # Enable RVM tab suggestion
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*

## Enable brew autocomplete
if type brew &>/dev/null
then
  HOMEBREW_PREFIX="$(brew --prefix)"
  if [[ -r "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh" ]]
  then
    source "${HOMEBREW_PREFIX}/etc/profile.d/bash_completion.sh"
  else
    for COMPLETION in "${HOMEBREW_PREFIX}/etc/bash_completion.d/"*
    do
      [[ -r "${COMPLETION}" ]] && source "${COMPLETION}"
    done
  fi
fi

## Pyenv configs
export PYENV_ROOT="$HOME/.pyenv"
command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
