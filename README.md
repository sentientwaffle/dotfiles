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

## Dependencies (apt-get)

  * tmux
    * xclip
  * cmus
    * vorbis-tools (vorbiscomment)

## Programs
### `copy`
Usage:

    $ cat foo.txt | copy

