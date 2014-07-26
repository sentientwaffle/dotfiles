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
# map Print Screen -> Super
xmodmap -e "keysym Print = Super_L"

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

exists() {
	type "$1" >/dev/null 2>/dev/null
}

# Udiskie/udisks: auto-mount USB
if exists udiskie; then
	udiskie --tray &
fi

# Disable touchpad while keyboard is in use.
if exists syndaemon; then
	syndaemon -t -k -i 1 &
fi


# Window manager
# Run in a loop so that if it crashes/reloads it comes back.
while true; do
  xrdb ~/.Xresources
  dwm 2> ~/.dwm.log
done
