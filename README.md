### Install

    $ git clone git@github.com:sentientwaffle/dotfiles.git ~/Code/dotfiles
    $ cd ~/Code/dotfiles
    $ git submodule init
    $ git submodule update
    $ ./install.sh

Some manual setup in `~/.bashrc` too:

    source ~/Code/dotfiles/.bashrc

### Configs
#### X

Reload `.Xresources`:

    $ xrdb ~/.Xresources

#### gpg

Reload `.gnupg/gpg-agent.conf`:

    $ echo RELOADAGENT | gpg-connect-agent

