#!/bin/bash

echo Installing packages...
__dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
bash ${__dir}/install.sh

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

echo Installing fuzzy reverse search...
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

echo Adding git prompt
curl https://raw.githubusercontent.com/git/git/master/contrib/completion/git-prompt.sh > ~/.git-prompt.sh

touch ~/.display.txt
mkdir ~/.logs

# Enable case-insensitive tab autocomplete
echo "set completion-ignore-case on" >> ~/.inputrc
