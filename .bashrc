alias bell="echo -e '\a'"
alias sourcebash="source ~/.bashrc"
alias ranbash="vim ~/.ranconf/.bashrc && sourcebash"

# Disable C-s from freezing the terminal
stty -ixon

# Export ~/bin
export PATH=$PATH":~/bin"

# Shortcut for going up
function cd_up() {
  cd $(printf "%0.0s../" $(seq 1 $1));
}
alias 'cd..'='cd_up'
