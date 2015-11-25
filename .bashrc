#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ##############################################################################
# Environment
# ##############################################################################
role='server'
if [[ -e ~/.xinitrc ]]; then
	role='desktop'
fi

export DOTFILES=$(dirname $BASH_SOURCE)
export EDITOR='vim'
export PAGER='less'
export HISTSIZE=10000
export HISTFILESIZE=10000
export HISTCONTROL=ignoredups:ignorespace

# Prompt
export PS1="\u@\h:\w\$(git symbolic-ref HEAD 2>&- | sed 's|refs/heads/\(.*\)$| \1|')\\$ "

# Path
export PATH="$DOTFILES/bin:$PATH"
export PATH="$HOME/Bootstrap/bin/$role:$PATH"
export PATH="$HOME/Bootstrap/bin/any:$PATH"

# python2 for node-gyp
export PYTHON='python2'
# nnm setup
export NNM_DIR="$HOME/Code/node"
export PATH="$NNM_DIR/current/bin:$PATH"

export JOURNAL_DIR="$HOME/Documents/journal"
export PASSWORD_STORE_CLIP_TIME=15

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s histappend

# ##############################################################################
# Aliases
# ##############################################################################
alias v='vim -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -AG --color'
alias ll='ls -lAF'
alias grep='grep --color'
alias ssh='ssh-add -l > /dev/null || ssh-add && TERM=screen-256color ssh'

alias jj='journal'
alias http='python2 -m SimpleHTTPServer'
alias winfo='xwininfo -display :0'
alias docker='sudo docker'
alias kindle-eject="sudo eject /run/media/$USER/Kindle"

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
# https://www.gnu.org/software/bash/manual/html_node/Programmable-Completion-Builtins.html

complete -A binding bind
complete -A setopt set
complete -A shopt shopt
complete -A helptopic help

complete -a alias unalias
complete -b builtin
complete -c type which
complete -cf man sudo
complete -d cd pushd rmdir

_complete() {
	local words=()
	case "$1" in
		journal) words=($(_complete_files.sh "$JOURNAL_DIR"    jtxt)) ;;
		pass)    words=($(_complete_files.sh ~/.password-store gpg)) ;;
		mux)     words=($(_complete_files.sh ~/Code/mux        txt)) ;;
		ssh)     words=($(grep '^Host' ~/.ssh/config | sed 's/^Host //')) ;;
	esac
	COMPREPLY=($(compgen -W "${words[*]}" -- "$2"))
}
complete -F _complete journal pass mux ssh

# ##############################################################################
# Terminal colors
# ##############################################################################

if [[ -n "$DISPLAY" && "$TERM" == 'xterm' ]]; then
	if [[ -f /usr/share/terminfo/t/tmux-256color ]]; then
		export TERM=tmux-256color
	else
		export TERM=screen-256color
	fi
fi

if [[ -x /usr/bin/dircolors ]]; then
	# dircolors doesn't work with tmux-256color.
	eval $(TERM=screen-256color dircolors --sh "$DOTFILES/.dircolors")
fi

# ##############################################################################
# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ "$XDG_VTNR" -eq 1 && -z "$DISPLAY" && -e ~/.xinitrc ]]; then
	exec startx
fi
