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

    source ~/dotfiles/.bashrc

## Dependencies (apt-get)

  * tmux
    * xclip
  * cmus
    * vorbis-tools (vorbiscomment)

## ./bin/
### `copy`
Usage:

    $ cat foo.txt | copy

### `gmail`
Get the number of unread emails from gmail.

The password is retreived from Ubuntu.
Create an item on the Ubuntu "Passwords and Keys" manager named "Gmail"
with your password.

The username and poll interval are constants in `bin/gmail`.

# Configs
## dwm

Reload `config.h`:

    $ cd ~/dwm
    $ makepkg -efi
    [MOD-Shift-Q]

## X

Reload `.Xresources`:

    $ xrdb ~/.Xresources

