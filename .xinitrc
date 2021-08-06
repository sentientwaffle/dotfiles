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

dm-keyboard-setup
dwm-status &

# Lock screen after inactivity.
xautolock -time 10 -locker slock &

# Start ssh-agent and gpg-agent
eval "$(ssh-agent)"
eval "$(gpg-agent --daemon)"

# PulseAudio
start-pulseaudio-x11

_exists() {
	type "$1" >/dev/null 2>&1
}

# Udiskie/udisks: auto-mount USB
if _exists udiskie; then
	udiskie --tray &
fi


# Window manager
# Run in a loop so that if it crashes/reloads it comes back.
while true; do
	xrdb ~/.Xresources
	dwm >~/.dwm.stdout.log 2>~/.dwm.stderr.log
done
