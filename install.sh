sudo apt-get update

sudo apt-get install -y \
  curl \
  vim-gtk \
  tmux \
  git \
  gnome-tweak-tool `# Swapping esc/caps` \
  fonts-powerline  `# Vim Airline font` \
  htop             `# Viewing processes` \
  iftop            `# Viewing network traffic` \
  xclip            `# Copying` \
  tree             `# Listing directories` \
  rsync            `# Syncing files` \
  pv               `# Progress bar` \
  silversearcher-ag`# Fast grep`

sudo snap install \
  universal-ctags    `# Tags for vim search`
