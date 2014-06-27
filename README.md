### Install

    $ git clone git@github.com:sentientwaffle/dotfiles.git ~/dotfiles
    $ cd ~/dotfiles
    $ git submodule init
    $ git submodule update
    $ ./install.sh

Some manual setup in `~/.bashrc` too:

    export NNM_DIR="$HOME/<NODE DIRECTORY>"
    export PATH="$NNM_DIR/current/bin:$PATH"
    source ~/dotfiles/.bashrc

### ./bin/
#### `copy`
Usage:

    $ cat foo.txt | copy

#### `gmail`
Get the number of unread emails from gmail.

The password is retreived from Ubuntu.
Create an item on the Ubuntu "Passwords and Keys" manager named "Gmail"
with your password.

The username and poll interval are constants in `bin/gmail`.

### Configs
#### X

Reload `.Xresources`:

    $ xrdb ~/.Xresources

