#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ##############################################################################
# Environment
# ##############################################################################
export DOTFILES="$HOME/Code/dotfiles"
export EDITOR='vim'
export PAGER='less'
export HISTSIZE=15000
export HISTFILESIZE=15000
export HISTCONTROL=ignoredups:ignorespace
export TZ='America/Los_Angeles'
export PS1="\u@\h:\w\$(git symbolic-ref HEAD 2>&- | sed 's|refs/heads/\(.*\)$| \1|')\\$ "

# Path
export PATH="$DOTFILES/bin:$PATH"

# python2 for node-gyp
export PYTHON='python2'
# nnm setup
export NNM_DIR="$HOME/Code/node"
export PATH="$NNM_DIR/current/bin:$PATH"

export JOURNAL_DIR="$HOME/Documents/journal"
export PASSWORD_STORE_CLIP_TIME=15

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
shopt -s histappend
shopt -s extglob

# ##############################################################################
# Aliases
# ##############################################################################
alias v='vim -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -A --color'
alias ll='ls -lAF'
alias grep='grep --color'
alias ssh='ssh-add -l > /dev/null || ssh-add && TERM=screen-256color ssh'

alias jj='journal open'
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
		jj)           words=($(_complete_files.sh "$JOURNAL_DIR"    jtxt)) ;;
		mux|mux-init) words=($(_complete_files.sh ~/Code/mux        txt)) ;;
		pass)         words=($(_complete_files.sh ~/.password-store gpg)) ;;
		ssh)          words=($(grep '^Host' ~/.ssh/config | sed 's/^Host //')) ;;
	esac
	COMPREPLY=($(compgen -W "${words[*]}" -- "$2"))
}
complete -F _complete jj pass mux mux-init ssh

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

[[ -e ~/Bootstrap/.bashrc ]] && source ~/Bootstrap/.bashrc

# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ "$XDG_VTNR" -eq 1 && -z "$DISPLAY" && -e ~/.xinitrc ]]; then
	exec startx &>~/.startx.log
fi
