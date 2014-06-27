#!/usr/bin/env bash

# If not running interactively, don't do anything
[ -z "$PS1" ] && return


# ##############################################################################
# Environment
# ##############################################################################

export HISTCONTROL=ignoredups:ignorespace
export EDITOR="vim"
export DOTFILES=$HOME/dotfiles
export HISTSIZE=5000
export PAGER='less'


# ##############################################################################
# Prompt
# ##############################################################################
export PS1="\u@\h:\w\$(git symbolic-ref HEAD 2>&- | sed 's|refs/heads/\(.*\)$| \1|')\\$ "

# ##############################################################################
# Path
# ##############################################################################
export PATH=$DOTFILES/bin:$PATH

# ##############################################################################
# Load other configs.
# ##############################################################################

if [ -x /usr/bin/dircolors ]; then
  eval `dircolors --sh $DOTFILES/.dircolors`
fi

# ##############################################################################
# Aliases
# ##############################################################################
alias v='vim -p'
alias ..='cd ..'
alias ...='cd ../..'
alias ls='ls -AG --color'
alias ll='ls -lAF'
alias grep='grep --color'
alias s='search'
alias http='python -m SimpleHTTPServer'

alias winfo='xwininfo -display :0'

# Git

alias g='git'

alias gs='git status'
alias gc='git commit'
alias gcm='git commit -m'

alias gd='git diff'
alias gdc='gd --cached'

alias gb='git branch'
alias gco='git checkout'
alias gm='git merge'
alias gf='git fetch'
alias gpr='git pull --rebase'

alias ga='git add'

alias glog="git log --graph --pretty=format:'%C(yellow)%h%Creset %an: %s - %Creset%C(yellow)%d%Creset%Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gg='git grep'

alias gsl='git stash list'

# ##############################################################################
# Terminal colors
# ##############################################################################
if [ -n "$DISPLAY" -a "$TERM" == "xterm" ]; then
  export TERM=screen-256color
fi

# Platform-independent interfaces
# via https://github.com/bahamas10/dotfiles/blob/master/bashrc
interfaces() {
  node <<-EOF
  var os = require('os');
  var i = os.networkInterfaces();
  var ret = {};
  Object.keys(i).forEach(function(name) {
    var ip4 = null;
    i[name].forEach(function(int) {
      if (int.family === 'IPv4') {
        ip4 = int.address;
        return;
      }
    });
    ret[name] = ip4;
  });
  console.log(JSON.stringify(ret, null, 2));
EOF
}

redwm() {
  # cd ~/dwm && makepkg -efi --noconfirm
  cd ~/dwm-git && make clean && sudo make install
}

# ##############################################################################

# Start X at login.
# https://wiki.archlinux.org/index.php/Start_X_at_Login
if [[ -z $DISPLAY && $XDG_VTNR -eq 1 ]]; then
  exec startx
fi
