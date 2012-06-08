# If not running interactively, don't do anything
[ -z "$PS1" ] && return

export HISTCONTROL=ignoredups:ignorespace
export EDITOR=vim
export DOTFILES=$HOME/dotfiles

# ##############################################################################
# Prompt
# ##############################################################################
export PS1="\u@\h:\w$ "

# ##############################################################################
# Path
# ##############################################################################
export PATH=$DOTFILES/bin:$PATH

# ##############################################################################
# Load other configs.
# ##############################################################################
for config_file in $DOTFILES/**/aliases.sh
do
  source $config_file
done

if [ -x /usr/bin/dircolors ]; then
  eval `dircolors --sh $DOTFILES/.dircolors`
fi

# ##############################################################################
# Aliases
# ##############################################################################
alias v='vim'
alias ..='cd ..'
alias ...='cd ../..'
alias la='ls -A'
alias ll='ls -lAF'
alias grep='grep --color'

# ##############################################################################
# Terminal colors
# ##############################################################################
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
  export TERM=screen-256color
fi


