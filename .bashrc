#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return 0

################################################################################
# Environment
# https://dom111.github.io/grep-colors/

export GREP_COLORS='sl=97;48;5;236:cx=37;40:mt=30;48;5;186:fn=38;5;197:ln=38;5;154:bn=38;5;141:se=38;5;81'
export TZ='America/Los_Angeles'
# python2 for node-gyp
export PYTHON='python2'

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

################################################################################
# Aliases

alias winfo='xwininfo -display :0'
alias lstar='tar -ztvf'
alias mktar='tar -cvzf'
alias untar='tar -zxvf'

################################################################################
# Completion
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
		pash)         mapfile -t words < <(_complete_files "$PASH_DIR" gpg) ;;
		ssh)          mapfile -t words < <(grep '^Host' ~/.ssh/config | sed 's/^Host //') ;;
	esac
	mapfile -t COMPREPLY < <(compgen -W "${words[*]}" -- "$2")
}
complete -F _complete dm-bmux jj mux mux-init pash ssh

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
	if [[ -r "$file" ]] && type "$1" >/dev/null 2>&1; then
		source "$file"
	fi
}
complete -F _lazy_complete \
	cal \
	journalctl \
	kubectl \
	makepkg \
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

################################################################################
# Terminal colors

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

################################################################################

# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ "$XDG_VTNR" -eq 1 && -z "$DISPLAY" && -e ~/.xinitrc ]]; then
	exec startx >~/.startx.log 2>&1
fi
