#!/usr/bin/env zsh

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'


# Check to see whether we are using gnu ls or ls and choose the appropriate
# flag to enable color on the ls output.
if [[ $(type ls) == "ls is /usr/local/opt/coreutils/libexec/gnubin/ls" ]] ; then
  export LS_OPTIONS="--color"
else
  export LS_OPTIONS="-G"
fi

alias l="ls $LS_OPTIONS -lFh"
alias la="ls $LS_OPTIONS -lFhA"


alias psx='ps aux'
alias ipecho='curl -s "https://api64.ipify.org?format=txt"'

#generate sha1
alias sha1sum='shasum -a 1'
alias sha256sum='shasum -a 256'
alias sha512sum='shasum -a 512'
alias md5sum='md5 -r'

alias firstword="cut -d' ' -f1"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias grepi='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias reload!='. ~/.zshrc'

alias find='noglob find'

# Functions
#
# (f)ind by (n)ame
# usage: fn foo
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }
