alias bell="echo -e '\a'"
alias sourcebash="source ~/.bashrc"

# Disable C-s from freezing the terminal
stty -ixon


# Loop.
loop() {
  while true; do
    $1;
    sleep 1;
  done;
}
