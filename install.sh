#!/usr/bin/env bash

symlink() {
	ln -sf "$DOTFILES/$1" "$2"
}

symlink ".conkyrc"    "$HOME/.conkyrc"
symlink ".gitconfig"  "$HOME/.gitconfig"
symlink ".gtkrc-2.0"  "$HOME/.gtkrc-2.0"
symlink ".tmux.conf"  "$HOME/.tmux.conf"
symlink ".vim"        "$HOME"
symlink ".vimrc"      "$HOME/.vimrc"
symlink ".xinitrc"    "$HOME/.xinitrc"
symlink ".Xresources" "$HOME/.Xresources"

mkdir -p "$HOME/.cmus"
symlink ".cmus/rc" "$HOME/.cmus/rc"

mkdir -p "$HOME/.config/fontconfig"
symlink ".config/fontconfig/fonts.conf" "$HOME/.config/fontconfig/fonts.conf"

mkdir -p "$HOME/.gnupg"
symlink ".gnupg/gpg.conf" "$HOME/.gnupg/gpg.conf"
