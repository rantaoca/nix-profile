alias bell="echo -e '\a'"
alias sourcebash="source ~/.bashrc"
alias editbash="vim ~/.bash_aliases; source ~/.bashrc"
alias ranbash="vim ~/.ranconf/.bashrc && sourcebash"
alias ranvim="vim ~/.ranconf/.vimrc"
alias adblog="adb logcat -c; adb logcat"
alias editranbash="vim ~/.ranconf/.bashrc; source ~/.bashrc"
alias ranconfpush="(cd ~/.ranconf; git commit -a; git push)"
alias ranconfpull="(cd ~/.ranconf; git pull; sourcebash)"

# Rsync files and show progress bar
ranrsync() {
  num_files=`rsync $1|wc -l`
  echo Syncing $num_files files
  rsync -arv --stats --human-readable $1 $2 | pv -pel -s $num_files > /dev/null
}

# Cd into the latest modified directory
cdlatest() {
  cd `ls -td -- */ | head -n 1`
}

# Save bash history
export PROMPT_COMMAND='if [ "$(id -u)" -ne 0 ]; then echo "$(date "+%Y-%m-%d.%H:%M:%S") $(pwd) $(history 1)" >> ~/.logs/bash-history-$(date "+%Y-%m-%d").log; fi'

grephistory() {
  grep -E $1 ~/.logs/bash-history-*
}

# Custom prompt with git
source ~/.git-prompt.sh
PS1='\A \[\033[0;32m\]\[\033[0m\033[0;32m\]\u\[\033[0;36m\] @ \[\033[0;36m\]\h \w\[\033[0;32m\]$(__git_ps1)\n\[\033[0;32m\]└─\[\033[0m\033[0;32m\] \$\[\033[0m\033[0;32m\] ▶\[\033[0m\] '

# Enable vim mode
set -o vi

# Disable C-s from freezing the terminal
stty -ixon


# Run a command over every second
loop () {
  while true; do
    $1;
    sleep 1;
  done;
}



# Export ~/bin
export PATH=$PATH":~/bin"

# Shortcut for going up n directories.
cdup () {
  cd $(printf "%0.0s../" $(seq 1 $1));
}
alias 'cd..'='cd_up'

# Bash bookmark system
# https://dmitryfrank.com/articles/shell_shortcuts

cdscuts_list_echo() {
  cat $1 | sed 's/#.*//g' | sed '/^\s*$/d'
}

cdscuts_glob_echo() {
	system_wide_filelist=''
	user_filelist=''
	 
	if [ -r /etc/cdg_paths ]; then
		 system_wide_filelist=$(cdscuts_list_echo /etc/cdg_paths)
	fi
	if [ -r ~/.cdg_paths ]; then
		 user_filelist=$(cdscuts_list_echo ~/.cdg_paths)
	fi
	 
	echo -e "$system_wide_filelist\n$user_filelist" | sed '/^\s*$/d'
}

# Fuzzy grep bookmarks
cdg() {
   local dest_dir=$(cdscuts_glob_echo | fzf )
   if [[ $dest_dir != '' ]]; then
      cd "$dest_dir"
   fi
}

# Bookmark current directory
cdb() {
  echo $(pwd) >> ~/.cdg_paths
}
export -f cdg > /dev/null

# Update Enable X11 forwarding in Tmux
# http://alexteichman.com/octo/blog/2014/01/01/x11-forwarding-and-terminal-multiplexers/
# -- Improved X11 forwarding through GNU Screen (or tmux).
# If not in screen or tmux, update the DISPLAY cache.
# If we are, update the value of DISPLAY to be that in the cache.
function update-x11-forwarding
{
    if [ -z "$STY" -a -z "$TMUX" ]; then
        echo $DISPLAY > ~/.display.txt
    else
        export DISPLAY=`cat ~/.display.txt`
    fi
}

# This is run before every command.
preexec() {
    # Don't cause a preexec for PROMPT_COMMAND.
    # Beware!  This fails if PROMPT_COMMAND is a string containing more than one command.
    [ "$BASH_COMMAND" = "$PROMPT_COMMAND" ] && return 

    update-x11-forwarding

    # Debugging.
    #echo DISPLAY = $DISPLAY, display.txt = `cat ~/.display.txt`, STY = $STY, TMUX = $TMUX  
}
trap 'preexec' DEBUG
