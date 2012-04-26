#!/bin/bash

# SETTINGS
NOW_PLAYING_PIPE="$HOME/.cmus/now-playing"


title=""
artist=""
stat="stopped"
url=""

while [ "$1" '!=' "" ]
do
    case "$1" in
        title)
            title="$2"
        ;;
        artist)
            artist="$2"
        ;;
        status)
            stat="$2"
        ;;
        file)
            file="$2"
        ;;
        url)
            url="$2"
        ;;
        *)
        ;;
    esac
    shift
    shift
done

msg=""
if [ "$stat" '=' 'stopped' ]
then
    msg="stopped"
else
    if [ -n "$title" ]
    then
        msg="$title"
    else
        if [ -n "$file" ]
        then
            msg="`basename "$file"`"
        else
            msg="<noname>"
        fi
    fi

    if [ -n "$artist" ]
    then
        msg="$artist - $msg"
    fi

    if [ "$stat" '=' 'paused' ]
    then
        msg="$msg [paused]"
    fi
fi

echo "$msg" > "$NOW_PLAYING_PIPE"
