alias bell="echo -e '\a'"
alias sourcebash="source ~/.bashrc"
alias editbash="vim ~/.bash_aliases; source ~/.bashrc"
alias ranbash="vim ~/.ranconf/.bashrc && sourcebash"
alias adblog="adb logcat -c; adb logcat"
alias editranbash="vim ~/.ranconf/.bashrc; source ~/.bashrc"

# Enable vim mode
set -o vi

# Disable C-s from freezing the terminal
stty -ixon


# Loop.
function loop () {
  while true; do
    $1;
    sleep 1;
  done;
}

# Export ~/bin
export PATH=$PATH":~/bin"

# Shortcut for going up
function cd_up () {
  cd $(printf "%0.0s../" $(seq 1 $1));
}
alias 'cd..'='cd_up'
