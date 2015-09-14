### Install

    $ git clone git@github.com:sentientwaffle/dotfiles.git ~/dotfiles
    $ cd ~/dotfiles
    $ git submodule init
    $ git submodule update
    $ ./install.sh

Some manual setup in `~/.bashrc` too:

    source ~/dotfiles/.bashrc

### ./bin/
#### `copy`
Usage:

    $ cat foo.txt | copy

#### `gmail`
Get the number of unread emails from gmail.

### Configs
#### X

Reload `.Xresources`:

    $ xrdb ~/.Xresources

#### gpg

Reload `.gnupg/gpg-agent.conf`:

    $ echo RELOADAGENT | gpg-connect-agent

