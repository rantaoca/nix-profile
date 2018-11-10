#!/bin/bash
apt-get install vim tmux git

# Include .bashrc
printf "\nsource ~/.ranconf/.bashrc\n" >> ~/.bashrc

# Include .gitconfig
printf "\n[include]\n  path = ~/.ranconf/.gitconfig\n" >> ~/.gitconfig

# Include .tmux.conf
printf "\nsource-file ~/.ranconf/.tmux.conf\n" >> ~/.tmux.conf

# Include .vimrc
printf "\nsource ~/.ranconf/.vimrc\n" >> ~/.vimrc 

# Install Vim Pathon Plugin Manager
mkdir -p ~/.vim/autoload ~/.vim/bundle && \
curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim

# Vim Pathogen Plugin Manager Plugins
git clone git://github.com/tpope/vim-abolish.git ~/.vim/bundle/vim-abolish
git clone https://github.com/scrooloose/nerdtree.git ~/.vim/bundle/nerdtree
