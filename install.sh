#!/bin/sh -eu

usage() {
	cat <<-EOF
	usage: ${0##*/} <desktop|desktop2|server>
	EOF
}

role=${1:-}
if [ "$role" != 'desktop' ] \
&& [ "$role" != 'desktop2' ] \
&& [ "$role" != 'server' ]; then
	usage >&2
	exit 1
fi
dotfiles=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

symlink() {
	_src="$dotfiles/$1"
	_dst="$HOME/$1"
	if [ -e "$_dst" ]; then
		if [ "$(readlink -f "$_src")" = "$(readlink -f "$_dst")" ]; then
			# The link already exists, and is correct.
			return
		fi
		echo "warning: Target $_dst already exists; skipping." >&2
		# This is technically an error, but with "set -e" we don't actually
		# want to exit.
		return
	fi
	printf 'ln -s "%s" "%s"\n' "$_src" "$_dst"
	ln -s "$_src" "$_dst"
}

if type 'bash' >/dev/null 2>&1; then symlink '.bashrc'; fi
if type 'vi'   >/dev/null 2>&1; then symlink '.exrc'; fi
if type 'git'  >/dev/null 2>&1; then symlink '.gitconfig'; fi
symlink '.inputrc'
if type 'lldb' >/dev/null 2>&1; then symlink '.lldbinit'; fi
if type 'tmux' >/dev/null 2>&1; then symlink '.tmux.conf'; fi
if type 'vim' >/dev/null 2>&1; then
	symlink '.vim'
	symlink '.vimrc'
	mkdir -p "$HOME/.cache/vim/undodir"
fi

if [ "$role" = 'desktop' ]; then
	symlink '.gtkrc-2.0'
	symlink '.xinitrc'
	symlink '.Xresources'
fi

if [ "$role" = 'desktop' ] || [ "$role" = 'desktop2' ]; then
	# TODO just symlink the directory?
	mkdir -p "$HOME/.config/fontconfig"
	symlink '.config/fontconfig/fonts.conf'
	mkdir -p "$HOME/.config/gtk-3.0"
	symlink '.config/gtk-3.0/settings.ini'
fi
