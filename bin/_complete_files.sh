#!/usr/bin/env bash

shopt -s nullglob globstar
usage() {
	cat <<-EOF
	usage: ${0##*/} <directory> <extension> [joinchar]

	Get a list of file names within the directory (recursively), with
	the given extension. The files are printed without the extension.
	EOF
}

dir=$1
ext=$2
char=${3-'\n'}
if [[ -z "$dir" || -z "$ext" ]]; then
	usage >&2
	exit 1
fi

files=( "$dir"/**/*."$ext" )
files=( "${files[@]#"$dir"/}" )
files=( "${files[@]%."$ext"}" )
printf "%s$char" "${files[@]}"
