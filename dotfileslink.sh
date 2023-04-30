#!/bin/sh

ln -sf $(pwd)/.vimrc ~/.vimrc
ln -sf $(pwd)/.profile ~/.profile
ln -sf $(pwd)/.bashrc ~/.bashrc
ln -sf $(pwd)/.gitmessage.txt ~/.gitmessage.txt
git config --global commit.template ~/.gitmessage.txt
