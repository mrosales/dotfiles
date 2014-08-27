# Example aliases
alias zshconfig="vim ~/.zshrc"
alias ohmyzsh="atom ~/.oh-my-zsh"

#aliases
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias ls='ls -lG'
alias la='ls -laG'
alias psx='ps aux'
alias ipecho='curl echoip.com ; echo'
alias todu='cd ~/dev/yc-hacks/todu-ios'

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

# git aliases (not in git plugin)
# see plugin wiki for all commands
# https://github.com/robbyrussell/oh-my-zsh/wiki/Plugin:git
alias gs='git status '
alias ga='git add '
alias go='git checkout '

#pebble aliases
alias pbil='pebble build && pebble install --logs'
