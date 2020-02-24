#!/usr/bin/env zsh
# Loads autojump plugin
if (( $+commands[brew] )) ; then
  [[ -s /usr/local/etc/autojump.sh ]] && . /usr/local/etc/autojump.sh
fi
