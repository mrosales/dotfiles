
# rbenv
if [ -f ~/.rbenv/shims ]; then
    export PATH=~/.rbenv/shims:$PATH
    eval "$(rbenv init -)"
fi

# Pebble SDK
export PATH=/Users/mrosales/pebble-dev/PebbleSDK-current/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PEBBLE_PHONE="10.0.127.164"
export PATH=/Users/mrosales/arm-cs-tools/bin:$PATH

#aliases
alias ..='cd ..'
alias ls='ls -lG'
alias la='ls -laG'
alias psx='ps aux'
alias ipecho='curl echoip.com ; echo'

#generates parent directories with mkdir
alias mkdirp='mkdir -pv'

#generate sha1
alias sha1='openssl sha1'

#shows/hides hidden files in finder
alias showf='defaults write com.apple.finder AppleShowAllFiles TRUE && killall Finder'
alias hidef='defaults write com.apple.finder AppleShowAllFiles FALSE && killall Finder'

## Colorize the grep command output for ease of use (good for log files)##
alias grep='grep --color=auto'
alias grepi='grep -i --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'

#git aliases
alias gs='git status '
alias ga='git add '
alias gb='git branch '
alias gc='git commit'
alias gd='git diff'
alias go='git checkout '

#extra scripts

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
