#!/usr/bin/env zsh

if type fnm &>/dev/null ; then
  _evalcache fnm env
  _evalcache fnm completions --shell zsh
fi
