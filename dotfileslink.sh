#!/bin/sh

ln -sf ~/dotfiles/.vimrc ~/.vimrc
ln -sf ~/dotfiles/.profile ~/.profile
ln -sf ~/dotfiles/.bashrc ~/.bashrc
ln -sf ~/dotfiles/.gitmessage.txt ~/.gitmessage.txt
git config --global commit.template ~/.gitmessage.txt
