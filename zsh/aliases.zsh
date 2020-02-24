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
alias ipecho='curl echoip.com ; echo'
alias zoo='ssh mhr35@node.zoo.cs.yale.edu'
#generates parent directories with mkdir
alias mkdirp='mkdir -pv'
alias runmongo='mongod --config /usr/local/etc/mongod.conf &'
alias runpostgres='(postgres -D /usr/local/var/postgres &) && echo "" ;'
alias psxg='ps aux | grepi'

#generate sha1
alias sha1='shasum -a 1'
alias sha256='shasum -a 256'
alias sha5125='shasum -a 512'
alias md5sum='echo "Alias not yet implemented."'

alias firstword="cut -d' ' -f1"

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias grepi='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias R="/usr/local/bin/R --quiet"

alias -g C='| wc -l'
alias -g H='| head'
alias -g L="| less"
alias -g N="| /dev/null"
alias -g S='| sort'
alias -g G='| grep' # now you can do: ls foo G something

# xcode ios simulator
alias simulator='open /Applications/Xcode.app/Contents/Developer/Applications/iOS\ Simulator.app'

alias reload!='. ~/.zshrc'

alias randstr='python -c "import random; print '"'%016x'"' % random.randrange(16**16)"'

alias randid='python -c "import sys; import random; sys.stdout.write('"'{:016X}.{:016X}'"'.format(random.randrange(16**16), random.randrange(16**16)))"'
# Functions
#
# (f)ind by (n)ame
# usage: fn foo
# to find all files containing 'foo' in the name
function fn() { ls **/*$1* }
