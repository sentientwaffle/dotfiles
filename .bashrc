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
export HISTFILESIZE=50000
export HISTSIZE=50000
export HISTTIMEFORMAT='%F %T '
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
# Transform multiline commands into single-lines.
shopt -s cmdhist
# Make glob match files starting with a '.'.
# https://mywiki.wooledge.org/glob
shopt -s dotglob
# https://www.gnu.org/software/bash/manual/html_node/Pattern-Matching.html
# https://mywiki.wooledge.org/BashGuide/Patterns
shopt -s extglob
# If a pattern fails to match, bash reports an expansion error.
shopt -s failglob
# Append to bash history, don't overwrite.
shopt -s histappend

# ##############################################################################
# Aliases
# ##############################################################################

# To run without the alias: e.g. "\grep".
alias ..='cd ..'
alias ...='cd ../..'
alias grep='grep --color --line-number --with-filename'
alias jj='journal open'
alias ll='ls -l --classify --human-readable'
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
alias gb='git branch'
alias gbl='git blame -- $(_fzy_find)'
alias gc='git commit'
alias gcm='git commit -m'
alias gcp='git cherry-pick'
alias gd='git diff'
alias gdc='gd --cached'
alias gf='git fetch'
alias gg='git grep --line-number'
# TODO print, too
alias gh='g rev-parse HEAD | cut -c "-7" | tr -d "\n" | copy'
alias glog="git log --graph --pretty=format:'%C(81)%h%C(250) %an:%Creset %s - %Creset%C(81)%d%Creset%C(141)(%cd)%Creset' --abbrev-commit --date=relative"
alias gm='git merge'
alias gpr='git pull --rebase'
alias grs='git restore --staged'
alias gs='git status'
alias gsl='git stash list'
alias gspsp='git stash && git pull --rebase && git stash pop'

# cd to the current git repo's root directory.
..g() {
	local root
	if root=$(git rev-parse --show-toplevel); then
		cd "$root" || return 1
	else
		return 1
	fi
}

glg() {
	if [ $# -eq 0 ]; then
		echo 'usage: glg <query>'      >&2
		echo 'Search commit messages.' >&2
		return 1
	fi
	git log --all --grep="$1"
}

# ##############################################################################
# Kubernetes
# ##############################################################################

if type 'kubectl' &>/dev/null; then
	alias kg='kctl get'
	alias kcp='kctl cp'
	alias kd='kctl describe'
	alias kl='kctl logs'
	alias kport='kctl port'
	alias kssh='kctl ssh'
	alias kw='kctl watch'
fi

# ##############################################################################
# Functions
# ##############################################################################

# This must be a function and not a separate script in `bin/` so that `cd`
# can change the working directory.
f() {
	local file
	file=$(_fzy_find "${1:-}") || return 1
	[[ ! -e $file ]] && return 1

	if [[ -d $file ]]; then
		cd "$file" || return 1
	else
		vim -- "$file"
	fi
}

c() {
	local dir
	dir=$(_fzy_dirs "${1:-}") || return 1
	[[ ! -d $dir ]] && return 1
	cd "$dir" || return 1
}

h() {
	eval "$(\grep -v '^#' ~/.bash_history \
		| tac \
		| fzy --query "${1:-}")"
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
complete -d cd pushd rmdir c

_complete() {
	local words=()
	case "$1" in
		dm-bmux)      mapfile -t words < <(_complete_files ~/Bootstrap/data/bmux txt) ;;
		jj)           mapfile -t words < <(_complete_files "$JOURNAL_DIR"    jtxt) ;;
		mux|mux-init) mapfile -t words < <(_complete_files ~/Bootstrap/data/mux  txt) ;;
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
	pass \
	rustup \
	systemctl \
	# Requires the bash-completion package to work:
	#pacman \
	#pacman-key \

if [[ -r /usr/share/bash-completion/completions/git ]]; then
	source /usr/share/bash-completion/completions/git
	__git_complete g   __git_main
	__git_complete ga  _git_add
	__git_complete gap _git_add
	__git_complete gau _git_add
	__git_complete gb  _git_branch
	__git_complete gc  _git_commit
	__git_complete gco _git_checkout
	__git_complete gcp _git_cherry_pick
	__git_complete gd  _git_diff
	__git_complete gdc _git_diff
	__git_complete gf  _git_fetch
	__git_complete gg  _git_grep
	__git_complete glog _git_log
	__git_complete gm  _git_merge
	__git_complete gpr _git_pull
	__git_complete grs _git_restore
	__git_complete gs  _git_status
	__git_complete gsl _git_stash
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
