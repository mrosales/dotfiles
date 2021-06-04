#!/usr/bin/env zsh
# Example aliases
alias zshconfig="subl ~/.zshrc"

#aliases

# Push and pop directories on directory stack
alias pu='pushd'
alias po='popd'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'

# List direcory contents
alias lsa='ls -lAGh'
alias l='ls -lAGFh'
alias ll='ls -lhG'
alias la='ls -lAhG'
# alias ls='ls -lG'

alias psx='ps aux'
alias ipecho='curl -s https://api64.ipify.org?format=txt'

#generate sha1
alias sha1='shasum -a 1'
alias sha256='shasum -a 256'
alias sha5125='shasum -a 512'
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
