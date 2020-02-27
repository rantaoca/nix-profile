#!/bin/bash

echo Installing packages...
sudo apt-get install curl vim tmux git \
  gnome-tweak-tool \ # For swapping esc/caps
  fonts-powerline \  # For vim Airline font
  htop               # For viewing processes

sudo apt-get install ripgrep # Only available on Ubuntu 18+

echo Adding .bashrc ...
printf "\nsource ~/.ranconf/.bashrc\n" >> ~/.bashrc

echo Adding .gitconfig ...
printf "\n[include]\n  path = ~/.ranconf/.gitconfig\n" >> ~/.gitconfig

echo Adding .tmux.conf ...
printf "\nsource-file ~/.ranconf/.tmux.conf\n" >> ~/.tmux.conf

echo Adding .vimrc ...
printf "\nsource ~/.ranconf/.vimrc\n" >> ~/.vimrc 

echo Downloading Tmux Plugin Manager...
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
