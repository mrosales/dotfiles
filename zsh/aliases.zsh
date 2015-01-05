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
alias lsa='ls -lah'
alias l='ls -lah'
alias ll='ls -lh'
alias la='ls -lAh'
alias ls='ls -lG'

alias psx='ps aux'
alias ipecho='curl echoip.com ; echo'
alias zoo='ssh mhr35@node.zoo.cs.yale.edu'
#generates parent directories with mkdir
alias mkdirp='mkdir -pv'
alias yfamongo='mongod --dbpath ~/mongo/db &'
alias psxg='ps aux | grepi'

#generate sha1
alias sha1='openssl sha1'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias grepi='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

alias reload!='. ~/.zshrc'
