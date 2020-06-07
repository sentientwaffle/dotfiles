#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# ##############################################################################
# Environment
# ##############################################################################
export DOTFILES="$HOME/Code/dotfiles"
export EDITOR='vim'
# https://dom111.github.io/grep-colors/
export GREP_COLORS='sl=97;48;5;236:cx=37;40:mt=30;48;5;186:fn=38;5;197:ln=38;5;154:bn=38;5;141:se=38;5;81'
export HISTCONTROL=ignoredups:ignorespace
export HISTFILESIZE=15000
export HISTSIZE=15000
export PAGER='less'
export PATH="$PATH:$DOTFILES/bin"
export PS1="\u@\h:\w\$(git symbolic-ref HEAD 2>&- | sed 's|refs/heads/\(.*\)$| \1|')\\$ "
export TZ='America/Los_Angeles'
export VISUAL='vim'

# python2 for node-gyp
export PYTHON='python2'
# nnm setup
export NNM_DIR="$HOME/Code/node"
export PATH="$PATH:$NNM_DIR/current/bin"

export JOURNAL_DIR="$HOME/Documents/journal"
export PASSWORD_STORE_CLIP_TIME=15

# http://www.gnu.org/software/bash/manual/html_node/The-Shopt-Builtin.html
# Make glob match files starting with a '.'.
# https://mywiki.wooledge.org/glob
shopt -s dotglob
# If a pattern fails to match, bash reports an expansion error.
shopt -s failglob
# https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
# https://mywiki.wooledge.org/BashGuide/Patterns
shopt -s extglob
shopt -s histappend

# ##############################################################################
# Aliases
# ##############################################################################

# To run without the alias: e.g. "\grep".
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color --line-number --with-filename'
alias jj='journal open'
alias ll='ls -l --classify'
alias ls='ls --almost-all --color=auto'
alias ssh='ssh-add -l > /dev/null || ssh-add && TERM=screen-256color ssh'
alias v='vim -p'
alias vt='vim "+set filetype=text"'
alias winfo='xwininfo -display :0'

# Git

alias g='git'
alias ga='git add'
alias gap='git add --interactive --patch'
alias gau='git add --update'
alias gb='git branch --sort=committerdate'
alias gc='git commit'
alias gcm='git commit -m'
#alias gco='git checkout'
alias gd='git diff'
alias gdc='gd --cached'
alias gf='git fetch'
alias gg='git grep --line-number'
alias glog="git log --graph --pretty=format:'%C(81)%h%C(250) %an:%Creset %s - %Creset%C(81)%d%Creset%C(141)(%cd)%Creset' --abbrev-commit --date=relative"
alias gm='git merge'
alias gpr='git pull --rebase'
alias gs='git status'
alias gsl='git stash list'
alias gspsp='git stash && git pull --rebase && git stash pop'

if type 'kubectl' &>/dev/null; then
	alias kd='kubectl describe'
	alias kg='kubectl get'
	alias kl='kubectl logs'

	# TODO it would be nice if this would automatically fall back to /bin/sh
	# when /bin/bash in unavailable.
	kssh() {
		set -x
		kubectl exec --stdin=true --tty=true $@ -- /bin/bash
		set +x
	}
fi

http() {
	local port=$1
	echo 'python2 -m SimpleHTTPServer '$port
	if [[ -z "$port" ]]; then
		python2 -m SimpleHTTPServer
	else
		# Listen on the specified port.
		python2 -m SimpleHTTPServer "$port"
	fi
}

# cd to the current git repo's root directory.
..g() {
	local root
	if root=$(git rev-parse --show-toplevel); then
		cd "$root" || return 1
	else
		return 1
	fi
}

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
complete -c command hash type watch which
complete -cf sudo
complete -d cd pushd rmdir

_complete() {
	local words=()
	case "$1" in
		dm-bmux)      mapfile -t words < <(_complete_files.sh ~/Code/bmux       txt) ;;
		jj)           mapfile -t words < <(_complete_files.sh "$JOURNAL_DIR"    jtxt) ;;
		mux|mux-init) mapfile -t words < <(_complete_files.sh ~/Code/mux        txt) ;;
		ssh)          mapfile -t words < <(grep '^Host' ~/.ssh/config | sed 's/^Host //') ;;
	esac
	mapfile -t COMPREPLY < <(compgen -W "${words[*]}" -- "$2")
}
complete -F _complete dm-bmux jj mux mux-init ssh

_complete_man() {
	mapfile -t COMPREPLY < <(apropos "$2" 2>/dev/null | awk '
		BEGIN { query="'"${2//\"/}"'" }
		substr($1, 0, length(query)) == query {
			print $1
		}
	')
}
complete -F _complete_man man

# Lazy-load completions.
_lazy_complete() {
	complete -r "$1"
	local file="/usr/share/bash-completion/completions/$1"
	if [[ -r "$file" ]] && type "$1" &>/dev/null; then
		source "$file"
	fi
}
complete -F _lazy_complete \
	cal \
	journalctl \
	kubectl \
	makepkg \
	mtr \
	pass \
	rustup \
	systemctl \
	# Requires the bash-completion package to work:
	#pacman \
	#pacman-key \

if [[ -r /usr/share/bash-completion/completions/git ]]; then
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
