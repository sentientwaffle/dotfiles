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
alias ga='git add'
alias gb='git branch'
alias gc='git commit'
alias gcm='git commit -m'
alias gco='git checkout'
alias gd='git diff'
alias gdc='gd --cached'
alias gf='git fetch'
alias gg='git grep'
alias glog="git log --graph --pretty=format:'%C(yellow)%h%Creset %an: %s - %Creset%C(yellow)%d%Creset%Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gm='git merge'
alias gpr='git pull --rebase'
alias gs='git status'
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
		jj)           mapfile -t words < <(_complete_files.sh "$JOURNAL_DIR"    jtxt) ;;
		mux|mux-init) mapfile -t words < <(_complete_files.sh ~/Code/mux        txt) ;;
		pass)         mapfile -t words < <(_complete_files.sh ~/.password-store gpg) ;;
		ssh)          mapfile -t words < <(grep '^Host' ~/.ssh/config | sed 's/^Host //') ;;
	esac
	mapfile -t COMPREPLY < <(compgen -W "${words[*]}" -- "$2")
}
complete -F _complete jj pass mux mux-init ssh

if [[ -f /usr/share/bash-completion/completions/git ]]; then
	# This might be slow.
	source /usr/share/bash-completion/completions/git
	__git_complete g   __git_main
	__git_complete ga  _git_add
	__git_complete gb  _git_branch
	__git_complete gc  _git_commit
	__git_complete gco _git_checkout
	__git_complete gd  _git_diff
	__git_complete gdc _git_diff
	__git_complete gf  _git_fetch
	__git_complete gg  _git_grep
	__git_complete gm  _git_merge
	__git_complete gpr _git_pull
	__git_complete gs  _git_status
fi

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
	eval "$(TERM=screen-256color dircolors --sh "$DOTFILES/.dircolors")"
fi

# ##############################################################################

[[ -e ~/Bootstrap/.bashrc ]] && source ~/Bootstrap/.bashrc

# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ "$XDG_VTNR" -eq 1 && -z "$DISPLAY" && -e ~/.xinitrc ]]; then
	exec startx &>~/.startx.log
fi
