# Override default path
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="/Users/mrosales/arm-cs-tools/bin:$PATH"
export PATH="/Users/mrosales/pebble-dev/PebbleSDK-current/bin:$PATH"
export MANPATH="/usr/local/man:$MANPATH"
export DOTFILES="$HOME/Dropbox/Apps/Dotfiles"

# Loads autojump plugin
[[ -s `brew --prefix`/etc/autojump.sh ]] && . `brew --prefix`/etc/autojump.sh

# Load RVM into a shell session *as a function*
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 
