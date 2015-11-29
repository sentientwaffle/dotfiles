#!/usr/bin/env bash

dotfiles="$(cd "$(dirname $BASH_SOURCE)" && echo "$PWD")"

usage() {
	cat <<-EOF
	usage: ${0##*/} <desktop|server>
	EOF
}

symlink() {
	ln -sf "$dotfiles/$1" "$2"
}

role=$1
if [[ "$role" != 'desktop' && "$role" != 'server' ]]; then
	usage >&2
	exit 1
fi

symlink '.bashrc'    "$HOME/.bashrc"
symlink '.gitconfig' "$HOME/.gitconfig"
symlink '.tmux.conf' "$HOME/.tmux.conf"
symlink '.vim'       "$HOME"
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
fi
