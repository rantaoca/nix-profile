#!/bin/bash

# Include .bashrc
printf "\nsource ~/.ranconf/.bashrc\n" >> ~/.bashrc

# Include .gitconfig
printf "\n[include]\n  path = ~/.ranconf/.gitconfig\n" >> ~/.gitconfig

# Include .tmux.conf
printf "\nsource-file ~/.ranconf/.tmux.conf\n" >> ~/.tmux.conf

# Include .vimrc
printf "\nsource ~/.ranconf/.vimrc\n" >> ~/.vimrc 
