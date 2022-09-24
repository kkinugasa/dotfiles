# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

# To avoid this issue https://github.com/GoogleCloudPlatform/github-actions/issues/128
export CLOUDSDK_PYTHON=/usr/bin/python3

export PATH="$PATH:/usr/local/go/bin"
if [ "$(which go)" ]; then
    export PATH="$PATH:$(go env GOPATH)/bin"
fi

export PATH="$PATH:/usr/local/android-studio/bin"
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# turn off bell in less related commands
# https://qiita.com/takuyanin/items/549c6f9cbdc85ac3ccd0
export LESS="-QiRMXS"

export PATH="$HOME/.elan/bin:$PATH"

# Integrated haskell platform
# https://ihp.digitallyinduced.com/Guide/index.html
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
export IHP_EDITOR="code --goto"

export QSYS_ROOTDIR="$HOME/intelFPGA_lite/21.1/quartus/sopc_builder/bin"
. "$HOME/.cargo/env"


# opam configuration
test -r $HOME/.opam/opam-init/init.sh && . $HOME/.opam/opam-init/init.sh > /dev/null 2> /dev/null || true

# https://volta.sh/
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
