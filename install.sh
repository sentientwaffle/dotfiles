#!/bin/sh -eu

usage() {
	cat <<-EOF
	usage: ${0##*/} <desktop|server>
	EOF
}

role=${1:-}
if [ "$role" != 'desktop' ] && [ "$role" != 'server' ]; then
	usage >&2
	exit 1
fi
dotfiles=$(CDPATH='' cd -- "$(dirname -- "$0")" && pwd)

symlink() {
	source="$dotfiles/$1"
	destination="$HOME/$1"
	if [ -e "$destination" ]; then
		if [ "$(readlink -f "$source")" = "$(readlink -f "$destination")" ]; then
			# The link already exists, and is correct.
			return 0
		fi
		printf 'Warning: File %s already exists; skipping.\n' "$destination" >&2
		return 1
	fi
	printf 'ln -s "%s" "%s"\n' "$source" "$destination"
	ln -s "$source" "$destination"
}

symlink '.bashrc'
symlink '.exrc'
symlink '.gitconfig'
symlink '.inputrc'
symlink '.lldbinit'
symlink '.tmux.conf'
symlink '.vim'
symlink '.vimrc'

mkdir -p "$HOME/.gnupg"
symlink '.gnupg/gpg.conf'
symlink '.gnupg/gpg-agent.conf'

if [ "$role" = 'desktop' ]; then
	symlink '.gtkrc-2.0'
	symlink '.xinitrc'
	symlink '.Xresources'

	mkdir -p "$HOME/.cmus"
	symlink '.cmus/rc'

	# TODO just symlink the directory?
	mkdir -p "$HOME/.config/fontconfig"
	symlink '.config/fontconfig/fonts.conf'
	mkdir -p "$HOME/.config/gtk-3.0"
	symlink '.config/gtk-3.0/settings.ini'

	symlink '.config/mimeapps.list'
fi
