#!/usr/bin/env bash

set -uo pipefail

dotfiles="$(cd "$(dirname "${BASH_SOURCE[0]}")" && echo "$PWD")"

usage() {
	cat <<-EOF
	usage: ${0##*/} <desktop|server>
	EOF
}

symlink() {
	local source="$dotfiles/$1"
	local destination="$2"
	if [[ -e "$destination" ]]; then
		if [[ $(readlink -f "$source") == $(readlink -f "$destination") ]]; then
			# The link already exists, and is correct.
			return 0
		fi
		echo 'Warning: File '"$destination"' already exists; skipping.' >&2
		return 1
	fi
	ln --symbolic "$source" "$destination"
}

role=${1:-}
if [[ "$role" != 'desktop' && "$role" != 'server' ]]; then
	usage >&2
	exit 1
fi

symlink '.bashrc'    "$HOME/.bashrc"
symlink '.exrc'      "$HOME/.exrc"
symlink '.gitconfig' "$HOME/.gitconfig"
symlink '.inputrc'   "$HOME/.inputrc"
symlink '.tmux.conf' "$HOME/.tmux.conf"
symlink '.vim'       "$HOME/.vim"
symlink '.vimrc'     "$HOME/.vimrc"

mkdir -p "$HOME/.gnupg"
symlink '.gnupg/gpg.conf'       "$HOME/.gnupg/gpg.conf"
symlink '.gnupg/gpg-agent.conf' "$HOME/.gnupg/gpg-agent.conf"

if [[ "$role" == 'desktop' ]]; then
	symlink '.gtkrc-2.0'  "$HOME/.gtkrc-2.0"
	symlink '.xinitrc'    "$HOME/.xinitrc"
	symlink '.Xresources' "$HOME/.Xresources"

	mkdir -p "$HOME/.cmus"
	symlink '.cmus/rc' "$HOME/.cmus/rc"

	mkdir -p "$HOME/.config/fontconfig"
	symlink '.config/fontconfig/fonts.conf' "$HOME/.config/fontconfig/fonts.conf"
	mkdir -p "$HOME/.config/gtk-3.0"
	symlink '.config/gtk-3.0/settings.ini' "$HOME/.config/gtk-3.0/settings.ini"

	symlink '.config/mimeapps.list' "$HOME/.config/mimeapps.list"
fi
