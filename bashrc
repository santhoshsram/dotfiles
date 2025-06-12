##################################
#                                #
#      BASH Functions            #
#                                #
##################################


function GIT_BRANCH_PROMPT()
{
   GIT_BRANCH=$(git branch 2>/dev/null| sed -n "/^\*/s/^\* //p")
   if [[ "$GIT_BRANCH" != "" ]]; then
      echo " /  $GIT_BRANCH /"
   else
      echo ""
   fi
}

function DockerImagesCleanAll()
{
   docker images | awk 'NR>1 {print $3}' | xargs -L 1 -t docker rmi -f
}

Machine=$(uname)

## Set the bash prompt
# Pattern for setting color -> \[\033[TEXTFORMAT;COLORm\]YOURTEXT
# To reset back to default color and format: \[\033[00m\]
#
# TEXTFORMATS
#	0 - no format
#	1 - bold
#	2 - darken
#	3 - italic
#	4 - underscore
#	5 - blink
#	9 - strikethrough
#
# FG COLORS
#	30	- black
#	31	- red
#	32 - green
#	33 - yellow
#	34 - blue
#	35 - purple
#	36	- cyan
#	37	- grey / white

# Breakup of below PS1 string
# PS1=
#  \[\033[1;37m\][                        -  <bold><white>[
#  \[\033[0;32m\]\w                       -  <green>path-to-current-dir
#   \[\033[0;34m\]`GIT_BRANCH_PROMPT`     -  <space><blue>(current-git-branch)<space>
#  \[\033[0;35m\](\D{%e-%b-%Y %T})        -  <purple>(29-Mar-2023 15:11:23)
#  \[\033[1;37m\]]                        -  <bold><white>]
#  \[\033[00m\]                           -  RESET to default style
#  \n                                     -  NEWLINE
#  \[\033[01;37m\]>                       -  <bold><white>RIGHT_ARROW1
#  \[\033[00m\] '                         -  RESET to default style<space>

PS1='\[\033[1;37m\][\[\033[0;32m\]\w \[\033[0;36m\]`GIT_BRANCH_PROMPT` \[\033[0;35m\](\D{%d-%b-%Y %T})\[\033[1;37m\] (mode: vim)]\[\033[00m\]\n\[\033[01;37m\]>\[\033[00m\] '
#PS1='\e[1;37m[\e[0;32m\w\e \e[0;34m`GIT_BRANCH_PROMPT` \e[0;35m(\D{%e-%b-%Y %T})\e[1;37m]\e[00m\n\e[01;37m>\e[00m '

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

alias ll='ls -ltrhF'
alias pd='pushd'
alias p='popd'
alias scrls='screen -ls'
alias scrctl='screen -m -A -d -R'
alias scrjoin='screen -A -x'
# tmux options
# -A if session with same name exists attach to it, if not create it
# -D if session is already attached to another terminal detach it there
# -s create session with name or attach to named session
alias tmx='tmux new -A -D -s'
alias docker-images-cleanall='DockerImagesCleanAll'
alias listen-ports='sudo lsof -i -P -n -i | grep LISTEN'

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

## Some modifications to persist bash history across tmux sessions

# Make sure bash history is persisted
# across sessions and not overwritten
shopt -s histappend

# Save history after each command
PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

# Increase the size of the history file
export HISTFILESIZE=10000
export HISTSIZE=5000

# Avoid duplicate entries
export HISTCONTROL=ignoredups:erasedups

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
eval "$(pyenv virtualenv-init -)"

# Add pipx bin path to PATH env var
# Created by `pipx` on 2023-04-03 17:40:48
export PATH="$PATH:/Users/santhosh/.local/bin"

# Enable pipx completions
eval "$(register-python-argcomplete pipx)"

# Install pip packages only in virtual envs
export PIP_REQUIRE_VIRTUALENV=true

# Configure shell for rust toolchain
[[ -r $HOME/.cargo/env ]] && . "$HOME/.cargo/env"

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# If a ~/.env.secrets exist source it
# Using dot notation (equivalent to source)
if [ -f ~/.env.secrets ]; then
   . ~/.env.secrets
fi

# Switch bash to vi/vim mode from emacs mode
set -o vi
# Key bindings for Ctrl-L to clear screen like in emacs mode
bind -m vi-insert '"\C-l": clear-screen'
bind -m vi-command '"\C-l": clear-screen'
