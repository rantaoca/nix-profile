#!/bin/bash

echo Installing packages...
sudo apt-get install curl vim tmux git \
  gnome-tweak-tool `# For swapping esc/caps` \
  fonts-powerline  `# For vim Airline font` \
  htop             `# For viewing processes` \
  xclip            `# For copying` \
  tree             `# For listing directories` \
  rsync            `# For syncing files` \
  pv               `# For progress bar`

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
