#!/usr/bin/env bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# Key mapping
# /usr/share/X11/xkb/rules/base.lst
setxkbmap -option ctrl:nocaps

# Key repeat
# Set:
#   $ xset r rate [delay (ms)] [rate (hz)]
# Get current value:
#   $ xset q
xset r rate 280 50

# TODO
# / {mail}
# / {network wired/wireless}
dwm-status &

# Lock screen after inactivity.
xautolock -time 10 -locker slock &

# Start ssh-agent and gpg-agent
eval "$(ssh-agent)"
eval "$(gpg-agent --daemon)"

# PulseAudio
start-pulseaudio-x11

# Window manager
# Run in a loop so that if it crashes/reloads it comes back.
while true; do
  xrdb ~/.Xresources
  dwm 2> ~/.dwm.log
done
