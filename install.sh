#!/usr/bin/env bash

ln -s "$PWD/.vimrc" "$HOME/.vimrc"
ln -s "$PWD/.tmux.conf" "$HOME/.tmux.conf"
ln -s "$PWD/.vim" "$HOME"

mkdir -p "$HOME/.cmus"
ln -s "$PWD/.cmus/current-track.sh" "$HOME/.cmus/current-track.sh"
ln -s "$PWD/.cmus/solarized.theme" "$HOME/.cmus/solarized.theme"

if [ ! -f "$HOME/.gitconfig" ];
then
  cp "$PWD/.gitconfig" "$HOME/.gitconfig"
fi

