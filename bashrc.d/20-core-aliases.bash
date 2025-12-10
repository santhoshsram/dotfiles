# Core Aliases

Machine=$(uname)

if [ "$Machine" = "Linux" ]; then
   alias ls='ls --color=auto'
   alias ll='ls -lh'
elif [ "$Machine" = "Darwin" ]; then
   alias ll='ls -l'
fi

alias ll='echo "Running: ls -ltrhF"; ls -ltrhF'
alias pd='pushd'
alias p='popd'

# screen
alias scrls='screen -ls'
alias scrctl='screen -m -A -d -R'
alias scrjoin='screen -A -x'

# tmux
# -A if session with same name exists attach to it, if not create it
# -D if session is already attached to another terminal detach it there
# -s create session with name or attach to named session
alias tmx='echo "Running: tmux new -A -D -s"; tmux new -A -D -s'

alias listen-ports='echo "Running: sudo lsof -i -P -n -i | grep LISTEN"; sudo lsof -i -P -n -i | grep LISTEN'
alias pwdcp='pwd | pbcopy; echo "Copied $PWD to clipboard"'

# nvim wrapper to handle pyenv virtualenv
alias nvim=nvimvenv
