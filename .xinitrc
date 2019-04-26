#!/usr/bin/env bash
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [[ -d /etc/X11/xinit/xinitrc.d ]]; then
	for f in /etc/X11/xinit/xinitrc.d/*; do
		[ -x "$f" ] && . "$f"
	done
	unset f
fi

# Keyboard settings: if these are updated, be sure to update dm-multihead at
# the same time so that new (external) keyboards get settings updated as well.

# Key mapping
# /usr/share/X11/xkb/rules/base.lst
setxkbmap -option ctrl:nocaps
# map Print Screen -> Super
xmodmap -e 'keysym Print = Super_L'

# Key repeat
# Set:
#   $ xset r rate [delay (ms)] [rate (hz)]
# Get current value:
#   $ xset q
xset r rate 280 50

# Disable keyboard bell
# <https://wiki.archlinux.org/index.php/PC_speaker>
xset -b

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


# Window manager
# Run in a loop so that if it crashes/reloads it comes back.
while true; do
	xrdb ~/.Xresources
	dwm >~/.dwm.stdout.log 2>~/.dwm.stderr.log
done
