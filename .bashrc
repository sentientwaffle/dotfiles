#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# ##############################################################################
# Environment
# ##############################################################################

export HISTCONTROL=ignoredups:ignorespace
export EDITOR="vim"
export DOTFILES=$(dirname $BASH_SOURCE)
export HISTSIZE=5000
export PAGER='less'

# Prompt
export PS1="\u@\h:\w\$(git symbolic-ref HEAD 2>&- | sed 's|refs/heads/\(.*\)$| \1|')\\$ "

# Path
export PATH=$DOTFILES/bin:$PATH

# ##############################################################################
# Load other configs.
# ##############################################################################

if [[ -x /usr/bin/dircolors ]]; then
	eval $(dircolors --sh "$DOTFILES/.dircolors")
fi

# ##############################################################################
# Aliases
# ##############################################################################
alias v='vim -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -AG --color'
alias ll='ls -lAF'
alias grep='grep --color'
alias ssh='ssh-add -l > /dev/null || ssh-add && ssh'

alias s='search'
alias http='python2 -m SimpleHTTPServer'
alias winfo='xwininfo -display :0'

# Git

alias g='git'

alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'

alias gd='git diff'
alias gdc='gd --cached'

alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias gf='git fetch'
alias gpr='git pull --rebase'

alias ga='git add'

alias glog="git log --graph --pretty=format:'%C(yellow)%h%Creset %an: %s - %Creset%C(yellow)%d%Creset%Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gg='git grep'

alias gsl='git stash list'

# ##############################################################################
# Completion
# ##############################################################################

complete -cf sudo
complete -cf man
complete -cf which
complete -W "$(echo $(grep '^Host' ~/.ssh/config | sed 's/^Host //'))" ssh

# ##############################################################################
# Terminal colors
# ##############################################################################
if [[ -n "$DISPLAY" && "$TERM" == "xterm" ]]; then
	export TERM=screen-256color
fi

# ##############################################################################

# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ $XDG_VTNR -eq 1 && -z $DISPLAY ]]; then
	exec startx
fi
