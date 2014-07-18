source ~/.bash_color_prompt

# rbenv
export PATH=~/.rbenv/shims:$PATH
eval "$(rbenv init -)"

# Pebble SDK
export PATH=/Users/mrosales/pebble-dev/PebbleSDK-current/bin:$PATH
export PATH=/usr/local/bin:$PATH
export PEBBLE_PHONE="10.0.127.164"
export PATH=/Users/mrosales/arm-cs-tools/bin:$PATH

#aliases
alias dev='cd ~/dev'
alias odev='open ~/dev'
alias @ios='cd ~/dev/iOS'
alias @web='cd ~/dev/web'
alias ..='cd ..'
alias ls='ls -lG'
alias la='ls -laG'
alias psx='ps -ax'
alias ipecho='curl echoip.com ; echo'

alias pbil='pebble build && pebble install && pebble logs'

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
