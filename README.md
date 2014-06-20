# Sentientwaffle's Dotfiles

Some defaults for Vim, [cmus](http://cmus.sourceforge.net/), Git, Bash,
and `ls`.

## Install

    $ git clone git://github.com/sentientwaffle/dotfiles.git ~/dotfiles
    $ cd ~/dotfiles
    $ git submodule init
    $ git submodule update
    $ ./install.sh

You will need to manually link/initialize the `.bashrc` file.

    source ~/dotfiles/bash/.bashrc

### Cmus

    :colorscheme solarized
    :set status_display_program=/home/x/.cmus/current-track.sh
    :save

## Dependencies (apt-get)

  * tmux
    * xclip
  * cmus
    * vorbis-tools (vorbiscomment)

## Programs
### `copy`
Usage:

    $ cat foo.txt | copy

### `gmail`
Get the number of unread emails from gmail.

The password is retreived from Ubuntu.
Create an item on the Ubuntu "Passwords and Keys" manager named "Gmail"
with your password.

The username and poll interval are constants in `bin/gmail`.

## dwm

Reload config file:

    $ cd ~/dwm
    $ makepkg -efi

