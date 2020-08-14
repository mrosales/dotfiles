#!/usr/bin/env zsh

if [ $commands[poetry] ] ; then
    eval $(poetry completions zsh)
fi
