#!/bin/sh -eu

exec shellcheck bin/* .bashrc .xinitrc install.sh lint.sh
